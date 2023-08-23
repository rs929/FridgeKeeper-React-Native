//
//  HomeTabBarViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    
    // MARK: - Tab View Controllers
    private let homeVC = HomeViewController()
    lazy var homeNavCtrl = UINavigationController(rootViewController: homeVC)
    private let ingredientsVC = IngredientsViewController()
    lazy var ingredientsNavCtrl = UINavigationController(rootViewController: ingredientsVC)
    private let recipesVC = RecipesViewController()
    lazy var recipesNavCtrl = UINavigationController(rootViewController: recipesVC)
    
    // MARK: - Views
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    // MARK: - Setup Views
    
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.black.cgColor
        homeNavCtrl.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.circle"), selectedImage: UIImage(systemName: "house.circle.fill"))
        ingredientsNavCtrl.tabBarItem = UITabBarItem(title: "Ingredients", image: UIImage(systemName: "fork.knife.circle"), selectedImage: UIImage(systemName: "fork.knife.circle.fill"))
        recipesNavCtrl.tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "book.circle"), selectedImage: UIImage(systemName: "book.circle.fill"))
        setViewControllers([homeNavCtrl, ingredientsNavCtrl, recipesNavCtrl], animated: false)
    }
    
    // MARK: - Helpers
}
