//
//  BasketViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 10.07.23.
//

import UIKit

class BasketViewCell: UITableViewCell {
    let customView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BasketCell")
        
        // Настройка внешнего вида customView
        customView.backgroundColor = .red
        customView.frame = CGRect(x: 10, y: 10, width: 100, height: 50)
        
        // Добавление customView в иерархию ячейки
        contentView.addSubview(customView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
