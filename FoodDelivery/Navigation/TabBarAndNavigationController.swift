//
//  TabBarAndNavigationController.swift
//  FoodDelivery
//
//  Created by Anton on 06.07.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        configureTabBar()
    }

    func generateTabBar() {
        let homeViewController = HomeViewController()
        let searchViewController = SearchViewController()
        let basketViewController = BasketViewController()
        let accountViewController = AccountViewController()
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        let basketNavigationController = UINavigationController(rootViewController: basketViewController)
        let accountNavigationController = UINavigationController(rootViewController: accountViewController)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "newspaper"), tag: 0)
        searchNavigationController.tabBarItem = UITabBarItem(title: "Sport", image: UIImage(systemName: "figure.hockey"), tag: 1)
        basketNavigationController.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(systemName: "suitcase"), tag: 2)
        accountNavigationController.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(systemName: "suitcase"), tag: 3)
        
        viewControllers = [homeNavigationController, searchNavigationController, basketNavigationController, accountNavigationController]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func configureTabBar() {
        let positionOnX: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let numberOfItems = CGFloat(tabBar.items?.count ?? 1)
        
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = width / max(numberOfItems, 1)
        tabBar.barTintColor = UIColor.systemBackground
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.systemBackground
        
       // updateTabBarColors()
    }
    
//    private func updateTabBarColors() {
//        if traitCollection.userInterfaceStyle == .dark {
//            tabBar.tintColor = UIColor.tabBarItemAccentDark
//            tabBar.unselectedItemTintColor = UIColor.tabBarItemUnselectedDark
//        } else {
//            tabBar.tintColor = UIColor.tabBarItemAccentWhite
//            tabBar.unselectedItemTintColor = UIColor.tabBarItemUnselectedWhite
//        }
//    }
    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        
//        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
//            updateTabBarColors()
//        }
//    }
}
