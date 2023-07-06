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
    
    func labelConfigure(with category: HomeCollectionContent) {
        myLabel.text = category.name
    }
    
    func imageConfigure(with category: HomeCollectionContent) {
        // Проверяем, что imageURL является валидным URL
        guard let imageURL = URL(string: category.imageURL) else {
            // Обработка некорректного URL
            return
        }
        
        // Создаем сессию URLSession
        let session = URLSession.shared
        
        // Создаем задачу для загрузки данных изображения
        let task = session.dataTask(with: imageURL) { [weak self] (data, response, error) in
            if let error = error {
                // Обработка ошибки загрузки данных
                print("Ошибка загрузки изображения: \(error)")
                return
            }
            
            // Проверяем, что получены данные изображения
            guard let imageData = data, let image = UIImage(data: imageData) else {
                // Обработка некорректных данных изображения
                print("Некорректные данные изображения")
                return
            }
            
            // Обновляем UI на основной очереди
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
        
        // Запускаем задачу загрузки данных
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
                               width: contentView.frame.size.width-10,
                               height: 50)
        myLabel.numberOfLines = 0
        
       
       
        
        imageView.frame = CGRect(x: 0,
                               y: 0,
                               width: contentView.frame.size.width,
                                   height: contentView.frame.size.height)
    }
}
