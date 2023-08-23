//
//  IngredientsViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class IngredientsViewController: BaseViewController {
    
    private var ingredients = [Ingredient]()
    private var searchedIngredients = [Ingredient]()
    private var isSearching: Bool = false
    
    // MARK: - Views
    
    private let emptyStateButton = UIButton()
    private let emptyStateLabel = UILabel()
    private let emptyStateMessageLabel = UILabel()
    private let emptyStateView = UIView()
    private let filterButton = UIButton()
    private let ingredientsTableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let searchBar = UISearchBar()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ingredients"
        
        fetchIngredients()
        setupSearchController()
        setupTableView()
        setupEmptyState()
    }
    
    // MARK: - Setup Views
    
    private func setupTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        
        view.addSubview(ingredientsTableView)
        ingredientsTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(fetchIngredients), for: .valueChanged)
        ingredientsTableView.refreshControl = refreshControl
    }
    
    private func setupSearchController() {
        searchBar.delegate = self
        searchBar.placeholder = "Search Ingredients"
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupEmptyState() {
        emptyStateLabel.text = "No Ingredients Found"
        emptyStateLabel.font = .customFont(of: 20, weight: .semibold)
        emptyStateView.addSubview(emptyStateLabel)
        
        emptyStateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        emptyStateMessageLabel.text = "If you can't find your ingredient, please click the button below."
        emptyStateMessageLabel.font = .customFont(of: 16, weight: .regular)
        emptyStateMessageLabel.textAlignment = .center
        emptyStateMessageLabel.numberOfLines = 0
        emptyStateView.addSubview(emptyStateMessageLabel)
        
        emptyStateMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStateLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        emptyStateButton.setTitle("Suggest an Ingredient", for: .normal)
        emptyStateButton.titleLabel?.font = .customFont(of: 18, weight: .semibold)
        emptyStateButton.layer.cornerRadius = 10
        emptyStateButton.layer.borderWidth = 1
        emptyStateButton.layer.borderColor = UIColor.black.cgColor
        emptyStateButton.setTitleColor(.black, for: .normal)
        emptyStateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        emptyStateView.addSubview(emptyStateButton)
        
        emptyStateButton.snp.makeConstraints { make in
            make.top.equalTo(emptyStateMessageLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
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
                    var type = IngredientType.other
                    if dataList[1] == "Spice/Condiment" {
                        type = .spiceOrCondiment
                    } else if dataList[1] == "Vegetable" {
                        type = .vegetable
                    }
                    
                    if !self.ingredients.contains(where: { ingredient in
                        ingredient.name == name
                    }) {
                        self.ingredients.append(Ingredient(name: name, image: URL(string: dataList[2]), type: type))
                    }
                })
                
                self.ingredients = self.ingredients.sorted(by: { ing1, ing2 in
                    ing1.name < ing2.name
                })
                
                self.emptyStateView.isHidden = true
                self.ingredientsTableView.reloadData()
                self.refreshControl.endRefreshing()
            case .failure(let error):
                print("Error in IngredientsViewController: \(error.localizedDescription)")
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @objc private func presentSuggestion() {
        let alertController = UIAlertController (
            title: "Suggest an Ingredient",
            message: "If you were unable to find your ingredient, please enter it below to make a suggestion to our database",
            preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) -> Void in
            let textField = alertController.textFields?.first as? UITextField
            
            // TODO: ADD SUGGESTION
            
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(submitAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Ingredient suggestion"
        }
        present(alertController, animated: true, completion: nil)
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
        isSearching ? searchedIngredients.count : ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseIdentifier) as! IngredientCell
        cell.configure(ingredient: isSearching ? searchedIngredients[indexPath.row] : ingredients[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UISearchBarDelegate
extension IngredientsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedIngredients = ingredients.filter({ ingredient in
            ingredient.name.lowercased().contains(searchText.lowercased())
        })
        
        isSearching = true
        ingredientsTableView.reloadData()
        
        emptyStateView.isHidden = !searchedIngredients.isEmpty
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
}

