//
//  DishesViewController.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class DishesViewController: UIViewController {
    
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
        DishesApiCaller.shareDish.getRequest { result in
            switch result {
            case .success(let dishes):
                self.dishesCollectionContent = dishes.map { dish in
                    DishesCollectionContent(
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
        dishesLayout.itemSize = CGSize(width: 109, height: 160)
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
        if collectionView == dishesCollectionView {
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
            
            return 10
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCell", for: indexPath)
            // Конфигурируйте ячейку для horizontalCollectionView
            return cell
        }
        return UICollectionViewCell()
    }
}

//MARK: - Extensions HorizontalViewController

