//
//  IngredientCell.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    static let reuseIdentifier = "IngredientCell"
    
    // MARK: - Views
    
    private let ingredientImageView = UIImageView()
    private let nameLabel = UILabel()
    private let typeLabel = UILabel()
    
    // MARK: Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        ingredientImageView.contentMode = .scaleAspectFit
        contentView.addSubview(ingredientImageView)
        
        ingredientImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(36)
        }
        
        nameLabel.font = .customFont(of: 18, weight: .semibold)
        nameLabel.textColor = .black
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(ingredientImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: Configure
    
    func configure(ingredient: Ingredient) {
        switch ingredient.type {
        case .spiceOrCondiment:
            ingredientImageView.image = UIImage(named: "spicesIcon")
        default:
            ingredientImageView.image = nil
        }
        
        nameLabel.text = ingredient.name
    }
}
