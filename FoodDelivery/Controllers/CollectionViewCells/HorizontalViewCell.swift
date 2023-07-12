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
        let backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 245/255, alpha: 1.0)
        contentView.backgroundColor = backgroundColor
        contentView.addSubview(horizontaNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func labelConfigure(with tagNames: [String]) {
        horizontaNameLabel.text = tagNames.joined(separator: ", ")
        horizontaNameLabel.numberOfLines = 0
        horizontaNameLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
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
