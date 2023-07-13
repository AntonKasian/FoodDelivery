//
//  BasketViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 10.07.23.
//

import UIKit

protocol BasketViewCellDelegate: AnyObject {
    func updatePayButtonPrice()
}

class BasketViewCell: UITableViewCell {
    
    weak var delegate: BasketViewCellDelegate?
    let customView = UIView()
    let busketImageView = UIImageView()
    let dishNameLabel = UILabel()
    let priceBusketLabel = UILabel()
    let weightBusketLabel = UILabel()
    let quantityView = UIView()
    let quantityMinusButton = UIButton()
    let quantityCount = UILabel()
    let quantityPlusButton = UIButton()
    
    weak var basketViewController: BasketViewController?
    
    var currentQuantity: Int = 1 {
        didSet {
            updatePriceLabel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BasketCell")
        
        contentView.addSubview(customView)
        contentView.addSubview(busketImageView)
        contentView.addSubview(dishNameLabel)
        contentView.addSubview(priceBusketLabel)
        contentView.addSubview(weightBusketLabel)
        contentView.addSubview(quantityView)
        contentView.addSubview(quantityMinusButton)
        contentView.addSubview(quantityCount)
        contentView.addSubview(quantityPlusButton)
        
        customViewConfigure()
        busketImageConfigure()
        dishNameConfigure()
        priceConfigure()
        weightConfigure()
        quantityConfigure()
        minusButtonConfigure()
        countConfigure()
        plusButtonConfigure()
        
        quantityPlusButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        quantityMinusButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        
    }
    
    func customViewConfigure() {
        customView.backgroundColor = .systemBackground
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        customView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        busketImageConfigure()
        customView.addSubview(busketImageView)
    }
    
    func busketImageConfigure() {
        busketImageView.frame = CGRect(x: 0, y: 0, width: 61, height: 61)
        busketImageView.backgroundColor = #colorLiteral(red: 0.9733045697, green: 0.9686054587, blue: 0.9599207044, alpha: 1)
    }
    
    func dishNameConfigure() {
        dishNameLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        dishNameLabel.numberOfLines = 0
        dishNameLabel.frame = CGRect(x: 70, y: 5, width: 110, height: 35)
    }
    
    func priceConfigure() {
        priceBusketLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        priceBusketLabel.frame = CGRect(x: 70, y: 45, width: 60, height: 14)
    }
    
    func weightConfigure() {
        weightBusketLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        weightBusketLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.45)
        weightBusketLabel.frame = CGRect(x: 120, y: 45, width: 60, height: 14)
    }
    
    func quantityConfigure() {
        let quantityColor = UIColor(red: 239/255, green: 238/255, blue: 236/255, alpha: 1.0)
        quantityView.backgroundColor = quantityColor
        quantityView.frame = CGRect(x: 260, y: 10, width: 99, height: 32)
        quantityView.translatesAutoresizingMaskIntoConstraints = false
        
        quantityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        quantityView.centerYAnchor.constraint(equalTo: customView.centerYAnchor).isActive = true
        quantityView.widthAnchor.constraint(equalToConstant: 99).isActive = true
        quantityView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        quantityView.layer.cornerRadius = 10
        
        quantityView.addSubview(quantityMinusButton)
    }
    
    func minusButtonConfigure() {
        quantityMinusButton.setTitle("-", for: .normal)
        quantityMinusButton.frame = CGRect(x: 5, y: 5, width: 24, height: 24)
        quantityMinusButton.setTitleColor(.black, for: .normal)
    }
    
    func countConfigure() {
        quantityCount.text = "1"
        quantityCount.textAlignment = .center
        
        quantityCount.translatesAutoresizingMaskIntoConstraints = false
        
        quantityCount.centerXAnchor.constraint(equalTo: quantityView.centerXAnchor, constant: 0).isActive = true
        quantityCount.centerYAnchor.constraint(equalTo: quantityView.centerYAnchor, constant: 0).isActive = true
        quantityCount.widthAnchor.constraint(equalToConstant: 24).isActive = true
        quantityCount.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func plusButtonConfigure() {
        quantityPlusButton.setTitle("+", for: .normal)
        quantityPlusButton.setTitleColor(.black, for: .normal)
        
        quantityPlusButton.translatesAutoresizingMaskIntoConstraints = false
        
        quantityPlusButton.trailingAnchor.constraint(equalTo: quantityView.trailingAnchor, constant: -5).isActive = true
        quantityPlusButton.centerYAnchor.constraint(equalTo: quantityView.centerYAnchor).isActive = true
        quantityPlusButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        quantityPlusButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func updatePriceLabel() {
        if let indexPath = basketViewController?.tableView.indexPath(for: self),
           let basketItem = basketViewController?.basketItems[indexPath.row]
        {
            let totalPrice = basketItem.price * currentQuantity
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = " "
            
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) {
                priceBusketLabel.text = "\(formattedPrice) ₽"
            }
        }
    }
    
    @objc func increaseQuantity() {
        currentQuantity += 1
        quantityCount.text = "\(currentQuantity)"
        updatePriceLabel()
        delegate?.updatePayButtonPrice()
    }
    
    @objc func decreaseQuantity() {
        if currentQuantity > 1 {
            currentQuantity -= 1
            quantityCount.text = "\(currentQuantity)"
            updatePriceLabel()
            delegate?.updatePayButtonPrice()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
