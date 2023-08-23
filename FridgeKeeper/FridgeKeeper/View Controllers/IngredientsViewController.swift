//
//  IngredientsViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class IngredientsViewController: BaseViewController {
    
    // MARK: - Views
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ingredients"
        
        NetworkManager.shared.getAllIngredients { result in
            switch result {
            case .success(let spreadsheet):
                print(spreadsheet?.sheets?.count)
            case .failure(let error):
                print("Error in IngredientsViewController: \(error)")
            }
        }
        
    }
    
    // MARK: - Setup Views
    
    // MARK: - Helpers
    
}

