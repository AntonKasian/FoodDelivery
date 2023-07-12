//
//  DishesViewController.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class DishesViewController: UIViewController, PopUpViewDelegate {
    
    func addDishToBasket(_ dish: Dish) {
        guard let tabBarController = tabBarController as? TabBarController else {
            print("Error tabBar with addDishToBasket in DishesViewController")
            return
        }
        
        for viewController in tabBarController.viewControllers ?? [] {
            if let basketNavigationController = viewController as? UINavigationController,
               let basketViewController = basketNavigationController.viewControllers.first as? BasketViewController {
                print("In addDishToBasket in DishesViewController all good")
                basketViewController.addDishToBasket(dish)
                return
            }
        }
        
        print("Error with addDishToBasket in DishesViewController")
    }

    
    private let photoView: UIView = {
        let image = UIImageView()
        image.image = UIImage(named: "AccountPhoto")
        
        return image
    }()
    
    let dishesLayout = UICollectionViewFlowLayout()
    
    var horizontalCollectionView: UICollectionView?
    let horizontalLayout = UICollectionViewFlowLayout()
    
    let dish = [Dish]()
    
    var dishesCollectionContent = [DishesCollectionContent]()
    var dishesCollectionView: UICollectionView?
    
    var selectedDishIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: photoView)
        
        //MARK: - DishesCollectionView
        
        dishesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: dishesLayout)
        dishesCollectionView?.contentInset = UIEdgeInsets(top: 60, left: 10, bottom: 80, right: 10)
        dishesLayoutConfigure()
        
        guard let dishesCollectionView = dishesCollectionView else { return }
        dishesCollectionView.register(DishesViewCell.self, forCellWithReuseIdentifier: "DishesCell")
        dishesCollectionView.dataSource = self
        dishesCollectionView.delegate = self
        dishesCollectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(dishesCollectionView)
        
        dishesCollectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height-100)
        
        //MARK: - HorizontalCollectionView
        
        horizontalCollectionView = UICollectionView(frame: .zero, collectionViewLayout: horizontalLayout)
        horizontalCollectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        horizontalLayoutConfigure()
        
        guard let horizontalCollectionView = horizontalCollectionView else { return }
        horizontalCollectionView.register(HorizontalViewCell.self, forCellWithReuseIdentifier: "HorizontalCell")
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        
        
        
        view.addSubview(horizontalCollectionView)
        
        horizontalCollectionView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 50)
        getDishes()
    }
    
    //MARK: - Network
    
    func getDishes() {
        DishesApiCaller.shareDish.getRequest { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dishes):
                self.dishesCollectionContent = dishes.map { dish in
                    DishesCollectionContent(
                        id: dish.id,
                        name: dish.name,
                        price: dish.price,
                        weight: dish.weight,
                        description: dish.description,
                        imageURL: dish.imageURL,
                        tegs: dish.tegs
                    )
                }
                DispatchQueue.main.async {
                    self.dishesCollectionView?.reloadData()
                }

            case .failure(let error):
                // Обработайте ошибку, если возникла
                print("Ошибка при получении данных: \(error)")
            }
        }
    }

    
    
    func dishesLayoutConfigure() {
        dishesLayout.scrollDirection = .vertical
        dishesLayout.itemSize = CGSize(width: 115, height: 160)
        dishesLayout.minimumLineSpacing = 10
        dishesLayout.minimumInteritemSpacing = 1
    }
    
    func horizontalLayoutConfigure() {
        horizontalLayout.scrollDirection = .horizontal
        horizontalLayout.itemSize = CGSize(width: 94, height: 35)
        horizontalLayout.minimumLineSpacing = 5
        horizontalLayout.minimumInteritemSpacing = 1
    }
    
}

//MARK: - Extensions DishesViewController

extension DishesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        selectedDishIndex = indexPath.row

        if collectionView == dishesCollectionView {
            let popUpView = PopUpView(frame: CGRect(x: 0, y: 0, width: 340, height: 470))
            popUpView.delegate = self
            view.addSubview(popUpView)
            popUpView.center = view.center

            if let selectedDishIndex = selectedDishIndex {
//                let selectedDish = dishesCollectionContent[selectedDishIndex]
//
//                popUpView.selectedDish = selectedDish
                let selectedDishesCollectionContent = dishesCollectionContent[selectedDishIndex]

                let selectedDish = Dish(id: selectedDishesCollectionContent.id, name: selectedDishesCollectionContent.name, price: selectedDishesCollectionContent.price, weight: selectedDishesCollectionContent.weight, description: selectedDishesCollectionContent.description, imageURL: selectedDishesCollectionContent.imageURL, tegs: selectedDishesCollectionContent.tegs)

                    popUpView.selectedDish = selectedDish

                popUpView.namePopUp.text = selectedDish.name
                popUpView.pricePopUp.text = "\(selectedDish.price) ₽"
                popUpView.weightPopUp.text = "• \(selectedDish.weight) г"
                popUpView.descriptionPopUp.text = selectedDish.description

                if let imageURL = URL(string: selectedDish.imageURL) {
                    URLSession.shared.dataTask(with: imageURL) { data, _, error in
                        if let error = error {
                            print("Ошибка при загрузке изображения: \(error)")
                        } else if let data = data, let dishImage = UIImage(data: data) {
                            DispatchQueue.main.async {
                                popUpView.dishImage = dishImage
                            }
                        }
                    }.resume()
                }
            }

            print("Dishes tapped")

        } else if collectionView == horizontalCollectionView {
            print("Horizontal tapped")
        }
    }

}

extension DishesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dishesCollectionView {
            return dishesCollectionContent.count
        } else if collectionView == horizontalCollectionView {
            
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dishesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DishesCell", for: indexPath) as! DishesViewCell
            
            let dishes = dishesCollectionContent[indexPath.row]
            cell.labelConfigure(with: dishes)
            cell.imageConfigure(with: dishes)
            cell.layer.cornerRadius = 10
            
            return cell
        } else if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath) as! HorizontalViewCell
            
            let tagNames = ["Все меню", "С рисом", "С рыбой", "Салаты"]
            let tagName = tagNames[indexPath.item]
            
            // Передайте объект DishesCollectionContent в ячейку
            cell.labelConfigure(with: [tagName])
            
            return cell
        }
        return UICollectionViewCell()
    }
}
            
            //MARK: - Extensions HorizontalViewController
