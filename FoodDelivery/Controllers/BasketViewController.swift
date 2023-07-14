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
        tableView.reloadData()
        updatePayButtonPrice()
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
    let payButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        payButtonConfigure()
        view.addSubview(tableView)
        view.addSubview(payButton)
        
    }
    
    func payButtonConfigure() {
        let color = UIColor(red: 0x33/255, green: 0x64/255, blue: 0xE0/255, alpha: 1.0)
        payButton.backgroundColor = color
        payButton.layer.cornerRadius = 10
        let totalPrice = basketItems.reduce(0) { $0 + $1.price }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        let formattedPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? ""
        
        let buttonText = "Оплатить \(formattedPrice) ₽"
        payButton.setTitle(buttonText, for: .normal)
        
        let buttonWidth: CGFloat = view.bounds.width - 10
        let buttonHeight: CGFloat = 48
        let buttonX = (view.bounds.width - buttonWidth) / 2
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let buttonY = view.bounds.height - tabBarHeight - buttonHeight - 20
        payButton.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
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
        tableView.frame = CGRect(x: 0, y: 70, width: view.bounds.width, height: view.bounds.height)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BasketViewCell.self, forCellReuseIdentifier: "BasketCell")
    }
    
}

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                basketItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                updatePayButtonPrice()
            }
        }
}

extension BasketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketViewCell
        
        let basketItem = basketItems[indexPath.row]
        
        cell.delegate = self
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

extension BasketViewController: BasketViewCellDelegate {
    
    func updatePayButtonPrice() {
        var totalPrice: Double = 0
        
        for indexPath in tableView.indexPathsForVisibleRows ?? [] {
            let basketItem = basketItems[indexPath.row]
            if let cell = tableView.cellForRow(at: indexPath) as? BasketViewCell {
                totalPrice += Double(basketItem.price * cell.currentQuantity)
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = " "
        
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) {
            let buttonText = "Оплатить \(formattedPrice) ₽"
            payButton.setTitle(buttonText, for: .normal)
        }
    }
    
}

