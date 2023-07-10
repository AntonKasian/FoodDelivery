//
//  PopUpViewController.swift
//  FoodDelivery
//
//  Created by Anton on 10.07.23.
//

import UIKit

class PopUpView: UIView {
    let closeButton = UIButton()
    let favouriteButton = UIButton()
    let imageView = UIImageView()
    let namePopUp = UILabel()
    let popUpView = PopUpView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        layer.cornerRadius = 15
        
        addSubview(closeButton)
        addSubview(imageView)
        
        closeButtonConfigure()
        favouriteButtonConfigure()
        imageViewConfigure()
        namePopUpConfigure()
    }
    
    func closeButtonConfigure() {
        closeButton.setImage(UIImage(named: "ClosePopUp"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.frame = CGRect(x: 265, y: 0, width: 40, height: 40)
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 10
    }
    
    func favouriteButtonConfigure() {
        favouriteButton.setImage(UIImage(named: "favouritePopUp"), for: .normal)
        favouriteButton.frame = CGRect(x: 220, y: 0, width: 40, height: 40)
        favouriteButton.backgroundColor = .white
        favouriteButton.layer.cornerRadius = 10
    }
    
    func imageViewConfigure() {
        imageView.frame = CGRect(x: 15, y: 15, width: 310, height: 230)
        imageView.backgroundColor = #colorLiteral(red: 0.9733045697, green: 0.9686054587, blue: 0.9599207044, alpha: 1)
        imageView.isUserInteractionEnabled = true

        imageView.addSubview(closeButton)
        imageView.addSubview(favouriteButton)
    }
    
    func namePopUpConfigure() {
        namePopUp.text = "Рыба с овощами и рисом"
        namePopUp.numberOfLines = 0
        namePopUp.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        namePopUp.frame = CGRect(x: 15, y: 250, width: popUpView.bounds.width - 15 , height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonTapped() {
        removeFromSuperview()
    }
}
