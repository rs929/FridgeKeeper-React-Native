//
//  RecipesViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

class RecipesViewController: BaseViewController {
    
    // MARK: - Data
    
    private let recipes = RecipeExamples.recipes
    
    // MARK: - Views
    
    let recipesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    } ()
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Recipes"
        
        setupCollectionView()
    }
    
    // MARK: - Setup Views
    
    private func setupCollectionView() {
        recipesCollectionView.register(RecipeCell.self, forCellWithReuseIdentifier: RecipeCell.reuseIdentifier)
        recipesCollectionView.dataSource = self
        recipesCollectionView.delegate = self
        view.addSubview(recipesCollectionView)
        
        recipesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    
}

// MARK: - UICollectionViewDataSource

extension RecipesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.reuseIdentifier, for: indexPath) as! RecipeCell
        
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension RecipesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = RecipeDetailsViewController(recipe: recipes[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 30) / 2, height: (view.frame.width - 30) / 2)
    }
}

