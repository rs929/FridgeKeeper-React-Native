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
    
    // MARK: - Views
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    // MARK: - Setup Views
    
    private func setupTabBar() {
        homeNavCtrl.tabBarItem = UITabBarItem(title: <#T##String?#>, image: <#T##UIImage?#>, selectedImage: <#T##UIImage?#>)
        setViewControllers([homeNavCtrl], animated: false)
    }
    
    // MARK: - Helpers
}
