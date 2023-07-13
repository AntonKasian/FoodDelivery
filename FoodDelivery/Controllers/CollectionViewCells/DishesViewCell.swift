//
//  DishesViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class DishesViewCell: UICollectionViewCell {
    
    static let identifire = "DishesCell"
    
    let dishesNameLabel = SOLabel()
    let dishesImageView = UIImageView()
    private let dish = [Dish]()
    
    func labelConfigure(with dish: DishesCollectionContent) {
        dishesNameLabel.text = dish.name
        dishesNameLabel.numberOfLines = 0
        dishesNameLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        
    }
    
    func imageConfigure(with dish: DishesCollectionContent) {
        guard let imageURL = URL(string: dish.imageURL) else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: imageURL) { [weak self] (data, response, error) in
            if let error = error {
                print("Ошибка загрузки изображения: \(error)")
                return
            }
            
            guard let imageData = data, let image = UIImage(data: imageData) else {
                print("Некорректные данные изображения")
                return
            }
            
            DispatchQueue.main.async {
                self?.dishesImageView.image = image
            }
        }
        task.resume()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(dishesNameLabel)
        contentView.addSubview(dishesImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dishesNameLabel.frame = CGRect(x: 0,
                               y: 110,
                               width: contentView.frame.width,
                               height: 60)
        dishesNameLabel.textAlignment = .left
        dishesNameLabel.verticalAlignment = .top
       
        dishesImageView.frame = CGRect(x: 0,
                               y: 0,
                               width: 109,
                               height: 109)
        dishesImageView.backgroundColor = #colorLiteral(red: 0.9733045697, green: 0.9686054587, blue: 0.9599207044, alpha: 1)
        dishesImageView.layer.cornerRadius = 15
        
    }
}
