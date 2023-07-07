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
    private let imageView = UIImageView()
    private let myLabel = UILabel()
    
    func labelConfigure(with category: MainCollectionContent) {
        myLabel.text = category.name
       // let font = UIFont(name: "SFProDisplay-Bold", size: 5)
        myLabel.numberOfLines = 0
        myLabel.font = UIFont.systemFont(ofSize: 20)
        
    }
    
    func imageConfigure(with category: MainCollectionContent) {
        guard let imageURL = URL(string: category.imageURL) else {
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
                self?.imageView.image = image
            }
        }
        task.resume()
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(imageView)
        contentView.addSubview(myLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       
        
        myLabel.frame = CGRect(x: 16,
                               y: 12,
                               width: 191,
                               height: 50)
       
        imageView.frame = CGRect(x: 0,
                               y: 0,
                               width: contentView.frame.size.width,
                               height: contentView.frame.size.height)
    }
}
