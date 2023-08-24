//
//  FridgeFilterCell.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/24/23.
//

import UIKit

class IngredientFilterCell: UICollectionViewCell {
    
    private var ingredientFilter = UILabel()
    static let reuseIdentifier = "IngredientFilterCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        ingredientFilter.font = .customFont(of: 14, weight: .semibold)
        ingredientFilter.backgroundColor = .systemGray5
        ingredientFilter.textAlignment = .center
        
        DispatchQueue.main.async {
            self.ingredientFilter.layer.cornerRadius = 15
            self.ingredientFilter.layer.masksToBounds = true
        }
        
        contentView.addSubview(ingredientFilter)
        
        ingredientFilter.snp.makeConstraints { make in
            make.height.equalTo(28)
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

    func configure(filter: String) {
        ingredientFilter.text = filter
    }
    
    func toggleBackgroundColor() {
        if isSelected {
            ingredientFilter.backgroundColor = .black
            ingredientFilter.textColor = .white
        } else {
            ingredientFilter.backgroundColor = .systemGray5
            ingredientFilter.textColor = .black
        }
    }
    
    func deselect() {
        ingredientFilter.backgroundColor = .systemGray5
        ingredientFilter.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
