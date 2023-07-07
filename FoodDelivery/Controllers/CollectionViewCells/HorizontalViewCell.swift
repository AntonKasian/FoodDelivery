//
//  HorizontalViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class HorizontalViewCell: UICollectionViewCell {
    static let identifire = "HorizontalCell"
    
    let horizontaNameLabel = UILabel()
    private let dish = [Dish]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .green
        contentView.addSubview(horizontaNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    func labelConfigure(with dish: DishesCollectionContent) {
//        horizontaNameLabel.text = dish.tegs.description
//        horizontaNameLabel.numberOfLines = 0
//        horizontaNameLabel.font = UIFont.systemFont(ofSize: 14)
//
//    }
    
    func labelConfigure(with tagNames: [String]) {
        horizontaNameLabel.text = tagNames.joined(separator: ", ")
        horizontaNameLabel.numberOfLines = 0
        horizontaNameLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        horizontaNameLabel.frame = CGRect(x: 0,
                                          y: 0,
                                          width: contentView.bounds.width,
                                          height: contentView.bounds.height)
        horizontaNameLabel.textAlignment = .center
        
    }
}
