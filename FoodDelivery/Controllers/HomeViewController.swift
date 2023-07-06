//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let locationView = UIView()
    let imageView = UIImageView()
    let currentDate = UILabel()
    let accountViewController = AccountViewController()
    let photoView: UIView = {
        let image = UIImageView()
        image.image = UIImage(named: "AccountPhoto")
        
        return image
    }()
    var collectionView: UICollectionView?
    
    let category = [Category]()
    let collectionContent = [HomeCollectionViewContent]()
    
    
    let text: UILabel = {
        let text = UILabel()
        text.text = "Санкт-Петербург"
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 50, right: 0)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width-10, height: 148)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        locationView.addSubview(imageView)
        locationView.addSubview(text)
        locationView.addSubview(currentDate)
        
        imageConfigure()
        currentDateConfigure()
        
        imageView.frame = CGRect(x: 0, y: -15, width: 24, height: 24)
        text.frame = CGRect(x: 30, y: -30, width: 145, height: 42)
        currentDate.frame = CGRect(x: 30, y: -6, width: 145, height: 42)
        collectionView.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: view.bounds.height-100)
        
        photoView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoViewTapped))
        photoView.addGestureRecognizer(tapGesture)

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: photoView)
        
        ApiCaller.share.getRequest { result in
            switch result {
            case .success(let categories):
                // API запрос выполнен успешно
                print("Количество категорий: \(categories.count)")
                for category in categories {
                    print("ID: \(category.id), Название: \(category.name), URL изображения: \(category.imageURL)")
                }
            case .failure(let error):
                // Произошла ошибка при выполнении API запроса
                print("Ошибка при выполнении API запроса: \(error)")
            }
        }

    }
    
    @objc func photoViewTapped() {
        navigationController?.pushViewController(accountViewController, animated: true)
    }
    
    //MARK: Configure
    
    func imageConfigure() {
        imageView.image = UIImage(named: "Icons")
    }
    
    func currentDateConfigure() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy"
        
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        
        let font = UIFont(name: "SFProDisplay-Regular", size: 14)
        self.currentDate.font = font
        self.currentDate.textColor = .gray
        
        self.currentDate.text = dateString
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? HomeViewCell else { return UICollectionViewCell() }
        
        let categories = category[indexPath.item]
        cell.labelConfigure(with: categories)
        cell.layer.cornerRadius = 10
        return cell
    }
}


