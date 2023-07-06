//
//  HomeViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    
    static let identifire = "CustomCell"
    let category = [Category]()
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private let myLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .green
        return label
    }()
    
    func labelConfigure(with category: Category) {
        myLabel.text = category.name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemRed
//        contentView.addSubview(myImageView)
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        myLabel.frame = CGRect(x: 5,
                               y: contentView.frame.size.height-50,
                               width: contentView.frame.size.width-10,
                               height: 50)
        
       
//        
//        myImageView.frame = CGRect(x: 5,
//                               y: 0,
//                               width: contentView.frame.size.width-10,
//                                   height: contentView.frame.size.height-50)
    }
}
