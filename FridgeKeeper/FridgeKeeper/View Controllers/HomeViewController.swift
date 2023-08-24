//
//  HomeViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private let allFilters = [
        "All",
        "Vegetables",
        "Fruits",
        "Proteins",
        "Dairy",
        "Spices/Condiments",
    ]
    
    private var filters = [String]()
    
    private var userIngredients = [Ingredient]()
    
    // MARK: - Views
    
    private let filterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let fridgeLabel = UILabel()
    private let fridgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumInteritemSpacing = 15
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right:16)
        return collectionView
    }()
    
    private let titleLabel = UILabel()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        
        // TODO: Edit Based on user ingredients (remove filters they don't have)
        filters = allFilters
        
        setupFilterCollectionView()
    }
    
    // MARK: - Setup Views
    
    private func setupFilterCollectionView() {
        titleLabel.text = "Your Fridge:"
        titleLabel.font = .customFont(of: 24, weight: .semibold)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(16)
        }
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.register(IngredientFilterCell.self, forCellWithReuseIdentifier: IngredientFilterCell.reuseIdentifier)
        view.addSubview(filterCollectionView)
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - Helpers
    
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            let font = UIFont.customFont(of: 14, weight: .semibold)!
            let fontAttributes = [NSAttributedString.Key.font: font]
            let text = filters[indexPath.row]
            let size = (text as NSString).size(withAttributes: fontAttributes)
            return CGSize(width: size.width + 24 , height: 40)
        } else {
            return CGSize()
        }
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == filterCollectionView ? filters.count : userIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientFilterCell.reuseIdentifier, for: indexPath) as! IngredientFilterCell
            cell.configure(filter: filters[indexPath.row])
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}
