//
//  IngredientCell.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import SDWebImage
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
        
        typeLabel.font = .customFont(of: 14, weight: .regular)
        typeLabel.textColor = .systemGray
        contentView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
    // MARK: Configure
    
    func configure(ingredient: Ingredient) {
        switch ingredient.type {
        case .spiceOrCondiment:
            ingredientImageView.image = UIImage(named: "spicesIcon")
        case .vegetable:
            ingredientImageView.image = UIImage(named: "vegetableIcon")
        case .fruit:
            ingredientImageView.image = UIImage(named: "fruitIcon")
        default:
            ingredientImageView.image = nil
        }
        
        if let url = ingredient.image {
            ingredientImageView.sd_setImage(with: url)
        }
        
        nameLabel.text = ingredient.name
        typeLabel.text = ingredient.type.rawValue
    }
}
