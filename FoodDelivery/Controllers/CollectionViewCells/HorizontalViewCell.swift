//
//  HorizontalViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 07.07.23.
//

import UIKit

class HorizontalViewCell: UICollectionViewCell {
    static let identifire = "HorizontalCell"
    
   // let horizontaNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
