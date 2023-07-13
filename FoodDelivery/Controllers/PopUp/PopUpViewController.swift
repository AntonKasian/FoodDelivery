//
//  PopUpViewController.swift
//  FoodDelivery
//
//  Created by Anton on 10.07.23.
//

import UIKit

protocol PopUpViewDelegate: AnyObject {
    func addDishToBasket(_ dish: Dish)
}

class PopUpView: UIView {
    
    weak var delegate: PopUpViewDelegate?
    
    var selectedDish: Dish? {
        didSet {
            if let selectedDish = selectedDish {
                
                namePopUp.text = selectedDish.name
                pricePopUp.text = "\(selectedDish.price) ₽"
                weightPopUp.text = "• \(selectedDish.weight) г"
                descriptionPopUp.text = selectedDish.description

            }
        }
    }
    
    var dimmingView: UIView?
    weak var tabBarController: UITabBarController?
    
    let closeButton = UIButton()
    let favouriteButton = UIButton()
    let imageView = UIImageView()
    let namePopUp = UILabel()
    let pricePopUp = UILabel()
    let weightPopUp = UILabel()
    let descriptionPopUp = UILabel()
    let addBusketButton = UIButton()

    var dishImage: UIImage? {
        didSet {
            imageView.image = dishImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        
        addSubview(closeButton)
        addSubview(imageView)
        addSubview(namePopUp)
        addSubview(pricePopUp)
        addSubview(weightPopUp)
        addSubview(descriptionPopUp)
        addSubview(addBusketButton)
        
        closeButtonConfigure()
        favouriteButtonConfigure()
        imageViewConfigure()
        namePopUpConfigure()
        priceConfigure()
        weightConfigure()
        descriptionConfigure()
        addBusketConfigure()
    }
    
    //MARK: - TAB BAR
    
    func darkenTabBar() {
        tabBarController?.tabBar.isTranslucent = true
        let color = dimmingView?.backgroundColor 
        tabBarController?.tabBar.barTintColor = color
    }
    
    func restoreTabBar() {
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.barTintColor = nil
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        restoreTabBar()
        
    }
    
    //MARK: - Configure
    
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
        imageView.layer.cornerRadius = 15
        imageView.addSubview(closeButton)
        imageView.addSubview(favouriteButton)
    }
    
    func namePopUpConfigure() {
        namePopUp.numberOfLines = 0
        namePopUp.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        namePopUp.frame = CGRect(x: 15, y: 250, width: frame.width - 30 , height: 20)
    }
    
    func priceConfigure() {
        pricePopUp.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        pricePopUp.frame = CGRect(x: 15, y: 270, width: frame.width - 30 , height: 20)
    }
    
    func weightConfigure() {
        weightPopUp.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        weightPopUp.frame = CGRect(x: 60, y: 270, width: frame.width - 30 , height: 20)
        weightPopUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
    }
    
    func descriptionConfigure() {
        descriptionPopUp.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        descriptionPopUp.frame = CGRect(x: 15, y: 287, width: frame.width - 30 , height: 120)
        descriptionPopUp.numberOfLines = 0
        descriptionPopUp.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.65)
    }
    
    func addBusketConfigure() {
        let buttonColor = UIColor(red: 51/255, green: 100/255, blue: 224/255, alpha: 1.0)
        addBusketButton.setTitle("Добавить в корзину", for: .normal)
        addBusketButton.frame = CGRect(x: 15, y: 412, width: frame.width - 30, height: 48)
        addBusketButton.backgroundColor = buttonColor
        addBusketButton.layer.cornerRadius = 15
        addBusketButton.addTarget(self, action: #selector(addBusketButtonTapped), for: .touchUpInside)
    }
    
    func showDimmingView() {
        dimmingView = UIView(frame: superview?.bounds ?? .zero)
        dimmingView?.backgroundColor = UIColor(white: 0, alpha: 0.2)
        dimmingView?.alpha = 0.0
        
        superview?.addSubview(dimmingView!)

        UIView.animate(withDuration: 0.3) {
            self.dimmingView?.alpha = 1.0
        }
    }
    
    func hideDimmingView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dimmingView?.alpha = 0.0
        }) { _ in
            self.dimmingView?.removeFromSuperview()
            self.dimmingView = nil
        }
    }
    
    @objc func addBusketButtonTapped() {
        
        guard let selectedDish = selectedDish else {
            print("Something wrong")
            return
        }
        
        delegate?.addDishToBasket(selectedDish)
        hideDimmingView()
        removeFromSuperview()
    }
    
    @objc func closeButtonTapped() {
        hideDimmingView()
        removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
