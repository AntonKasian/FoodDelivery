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
    var collectionContent = [MainCollectionContent]()
    let layout = UICollectionViewFlowLayout()

    let cityNameLabel: UILabel = {
        let text = UILabel()
        text.text = "Санкт-Петербург"
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 50, right: 0)
        layoutConfigure()
        
        guard let collectionView = collectionView else { return }
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        locationViewConfigure()
        imageConfigure()
        currentDateConfigure()
        
        imageView.frame = CGRect(x: 0, y: -15, width: 24, height: 24)
        cityNameLabel.frame = CGRect(x: 30, y: -30, width: 145, height: 42)
        currentDate.frame = CGRect(x: 30, y: -6, width: 145, height: 42)
        collectionView.frame = CGRect(x: 0, y: 60, width: view.bounds.width, height: view.bounds.height-100)
        
        photoView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoViewTapped))
        photoView.addGestureRecognizer(tapGesture)

        fetchContent()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: locationView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: photoView)
    }
    
    @objc func photoViewTapped() {
        navigationController?.pushViewController(accountViewController, animated: true)
    }
    
    //MARK: - API
    
    func fetchContent() {
        ApiCallerMain.share.getRequest { result in
            switch result {
            case .success(let categories):
                self.collectionContent = categories.map { MainCollectionContent(name: $0.name, imageURL: $0.imageURL) }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            case .failure(let error):
                // Обработка ошибки
                print("Ошибка при выполнении API запроса: \(error)")
            }
        }
    }
    
    //MARK: - Configure
    
    func imageConfigure() {
        imageView.image = UIImage(named: "Icons")
    }
    
    func locationViewConfigure() {
        locationView.addSubview(imageView)
        locationView.addSubview(cityNameLabel)
        locationView.addSubview(currentDate)
    }
    
    func layoutConfigure() {
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width - 10, height: 148)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
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

//MARK: - Extensions

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        print("You tapped me")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionContent.count // не видно из-за этого
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! HomeViewCell
        
        let categories = collectionContent[indexPath.item]
        cell.labelConfigure(with: categories)
        cell.imageConfigure(with: categories)
        cell.layer.cornerRadius = 10
        return cell
    }
}


