//
//  HomeViewCell.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

protocol HomeViewCellDelegate: AnyObject {
    func didSelectCell(withTitle title: String)
}

class HomeViewCell: UICollectionViewCell {
    
    static let identifire = "HomeCell"
    weak var delegate: HomeViewCellDelegate?
    
    let category = [Category]()
    private let categoryImageView = UIImageView()
    let nameCategoryLabel = UILabel()
    
    func labelConfigure(with category: MainCollectionContent) {
        nameCategoryLabel.text = category.name
       // let font = UIFont(name: "SFProDisplay-Bold", size: 5)
        nameCategoryLabel.numberOfLines = 0
        nameCategoryLabel.font = UIFont.systemFont(ofSize: 20)
        
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
                self?.categoryImageView.image = image
            }
        }
        task.resume()
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 10
        contentView.addSubview(categoryImageView)
        contentView.addSubview(nameCategoryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       
        
        nameCategoryLabel.frame = CGRect(x: 16,
                               y: 12,
                               width: 191,
                               height: 50)
       
        categoryImageView.frame = CGRect(x: 0,
                               y: 0,
                               width: contentView.frame.size.width,
                               height: contentView.frame.size.height)
    }
}
