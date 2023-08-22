//
//  BaseViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Views
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Setup Views
    private func setupHeader() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.customFont(of: 24, weight: .semibold)]
    }
    
    // MARK: - Helpers
    
}
