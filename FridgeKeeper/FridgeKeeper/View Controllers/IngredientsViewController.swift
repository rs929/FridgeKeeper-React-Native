//
//  IngredientsViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class IngredientsViewController: BaseViewController {
    
    private var ingredients = [Ingredient]()
    
    // MARK: - Views
    
    private let ingredientsTableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ingredients"
        
        fetchIngredients()
        setupTableView()
    }
    
    // MARK: - Setup Views
    
    private func setupTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        
        view.addSubview(ingredientsTableView)
        ingredientsTableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(fetchIngredients), for: .valueChanged)
        ingredientsTableView.refreshControl = refreshControl
    }
    
    // MARK: - Helpers
    
    @objc private func fetchIngredients() {
        print("Fetch")
        NetworkManager.shared.readData { result in
            switch result {
            case .success(let data):
                let stringData = data.values as? [[String]]
                
                self.ingredients = []
                
                stringData?.forEach({ dataList in
                    let name = dataList[0]
                    let type = dataList[1]
                    if !self.ingredients.contains(where: { ingredient in
                        ingredient.name == name
                    }) {
                        self.ingredients.append(Ingredient(name: name, image: nil, type: .spiceOrCondiment))
                    }
                })
                
                self.ingredients = self.ingredients.sorted(by: { ing1, ing2 in
                    ing1.name < ing2.name
                })
                
                self.ingredientsTableView.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print("Error in IngredientsViewController: \(error.localizedDescription)")
                self.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: UITableViewDelegate
extension IngredientsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}

// MARK: UITableViewDataSource
extension IngredientsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseIdentifier) as! IngredientCell
        cell.configure(ingredient: ingredients[indexPath.row])
        
        return cell
    }
    
}

