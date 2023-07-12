//
//  BasketViewController.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

class BasketViewController: UIViewController {
    
    var basketItems: [Dish] = []
    
    func addDishToBasket(_ dish: Dish) {
        basketItems.append(dish)
        tableView.reloadData() // Обновите таблицу для отображения добавленного блюда в корзине
    }
    
    private let photoView: UIView = {
        let image = UIImageView()
        image.image = UIImage(named: "AccountPhoto")
        
        return image
    }()
    
    let cityNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Санкт-Петербург"
        return text
    }()
    
    let currentDate = UILabel()
    let locationView = UIView()
    let imageView = UIImageView()
    let tableView = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Корзина"
        view.backgroundColor = .systemBackground
        
        locationViewConfigure()
        currentDateConfigure()
        imageConfigure()
        
        imageView.frame = CGRect(x: 0, y: -15, width: 24, height: 24)
        cityNameLabel.frame = CGRect(x: 30, y: -30, width: 145, height: 42)
        currentDate.frame = CGRect(x: 30, y: -6, width: 145, height: 42)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: photoView)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationView)
        
        tableViewConfigure()
        view.addSubview(tableView)
        
    }
    
    func locationViewConfigure() {
        locationView.addSubview(imageView)
        locationView.addSubview(cityNameLabel)
        locationView.addSubview(currentDate)
    }
    
    func currentDateConfigure() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let font = UIFont(name: "SFProDisplay-Regular", size: 14)
        self.currentDate.font = font
        self.currentDate.textColor = .gray
        
        self.currentDate.text = dateString
    }
    
    func imageConfigure() {
        imageView.image = UIImage(named: "Icons")
    }
    
    func tableViewConfigure() {
        tableView.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: view.bounds.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BasketViewCell.self, forCellReuseIdentifier: "BasketCell")
    }

}

extension BasketViewController: UITableViewDelegate {
    
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketViewCell
        
        let basketItem = basketItems[indexPath.row]
        
        
        cell.basketViewController = self
        
        
        cell.dishNameLabel.text = basketItem.name
        cell.priceBusketLabel.text = "\(basketItem.price) ₽"
        cell.weightBusketLabel.text = "• \(basketItem.weight) г"
        
        if let imageURL = URL(string: basketItem.imageURL) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Ошибка при загрузке изображения: \(error)")
                } else if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.busketImageView.image = image
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
}
