//
//  IngredientsViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class IngredientsViewController: BaseViewController {
    
    private let allFilters = [
        "All",
        "Vegetables",
        "Fruits",
        "Proteins",
        "Dairy",
        "Spices/Condiments",
        "Other"
    ]
    
    private var allIngredients = [Ingredient]()
    private var allSearchedIngredients = [Ingredient]()
    
    private var ingredients = [Ingredient]()
    private var searchedIngredients = [Ingredient]()
    
    private var isSearching: Bool = false
    
    private var userIngredients = [Ingredient]()
    
    // MARK: - Views
    
    private let emptyStateButton = UIButton()
    private let emptyStateLabel = UILabel()
    private let emptyStateMessageLabel = UILabel()
    private let emptyStateView = UIView()
    private let filterButton = UIButton()
    
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()
    
    private let ingredientsTableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let searchBar = CustomSearchBar()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Ingredients"
        
        fetchIngredients()
        setupSearchController()
        setupFilterCollectionView()
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
            make.top.equalTo(filterCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        refreshControl.addTarget(self, action: #selector(fetchIngredients), for: .valueChanged)
        ingredientsTableView.refreshControl = refreshControl
    }
    
    private func setupSearchController() {
        searchBar.searchTextField.delegate = self
        searchBar.setup(placeholder: "Search Ingredients")
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
        filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .selected)
        filterButton.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        
        filterButton.imageView?.snp.updateConstraints { make in
            make.size.equalTo(36)
        }
        
        view.addSubview(filterButton)
        
        filterButton.snp.makeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing)
            make.centerY.equalTo(searchBar)
            make.size.equalTo(40)
        }
    }
    
    private func setupFilterCollectionView() {
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(IngredientFilterCell.self, forCellWithReuseIdentifier: IngredientFilterCell.reuseIdentifier)
        view.addSubview(filterCollectionView)
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(0)
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
                
                self.allIngredients = self.ingredients
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
    
    @objc private func showFilters() {
        filterButton.isSelected.toggle()
        
        UIView.transition(with: filterCollectionView, duration: 0.5, options: .transitionCrossDissolve) {
            if self.filterButton.isSelected {
                self.filterCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(40)
                }
            } else {
                self.filterCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
        }
        
    }
    
    private func filter(topic: String, isSearching: Bool) {
        var ingredients = isSearching ? self.searchedIngredients : self.allIngredients
        
        if topic == "All" {
            ingredients = isSearching ? searchedIngredients : allIngredients
        } else if topic == "Spices/Condiments" {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .spiceOrCondiment
            })
        } else if topic == "Vegetables" {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .vegetable
            })
        } else if topic == "Fruits" {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .fruit
            })
        } else if topic == "Protiens" {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .protein
            })
        } else if topic == "Dairy" {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .dairy
            })
        } else {
            ingredients = ingredients.filter({ ingredient in
                ingredient.type == .other
            })
        }
        
        if isSearching {
            searchedIngredients = ingredients
        } else {
            self.ingredients = ingredients
        }
        
        ingredientsTableView.reloadData()
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

// MARK: UITextFieldDelegate
extension IngredientsViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchedIngredients = ingredients.filter({ ingredient in
            ingredient.name.lowercased().contains(textField.text?.lowercased() ?? "")
        })
        
        isSearching = true
        
        emptyStateView.isHidden = !searchedIngredients.isEmpty
        
        if textField.text?.isEmpty ?? true {
            isSearching = false
            emptyStateView.isHidden = true
        }
        
        ingredientsTableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isSearching = false
    }
}

// MARK: UICollectionViewDelegate
extension IngredientsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            collectionView.visibleCells.forEach { cell in
                let ingredientCell = cell as! IngredientFilterCell
                ingredientCell.isSelected = false
                ingredientCell.toggleBackgroundColor()
            }
            
            let selectedCell = collectionView.cellForItem(at: indexPath) as! IngredientFilterCell
            selectedCell.isSelected = true
            selectedCell.toggleBackgroundColor()
            
            // TODO: FIlter Function Here
            
            filter(topic: allFilters[indexPath.row], isSearching: isSearching)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.customFont(of: 14, weight: .semibold)!
        let fontAttributes = [NSAttributedString.Key.font: font]
        let text = allFilters[indexPath.row]
        let size = (text as NSString).size(withAttributes: fontAttributes)
        return CGSize(width: size.width + 24 , height: 40)
    }
    
}

// MARK: UICollectionViewDataSource
extension IngredientsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientFilterCell.reuseIdentifier, for: indexPath) as! IngredientFilterCell
        cell.configure(filter: allFilters[indexPath.row])
        
        return cell
    }

}


