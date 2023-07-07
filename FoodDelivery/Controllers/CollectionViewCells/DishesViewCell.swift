//
//  DishesViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class DishesViewCell: UICollectionViewCell {
    
    static let identifire = "DishesCell"
    
    let dishesNameLabel = UILabel()
    private let dishesImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
