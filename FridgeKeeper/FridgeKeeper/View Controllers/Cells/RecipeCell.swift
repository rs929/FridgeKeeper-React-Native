//
//  RecipeCell.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecipeCell"
    
    // MARK: - Views
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        nameLabel.font = .customFont(of: 18, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        nameLabel.layer.cornerRadius = 8
        nameLabel.backgroundColor = .systemGray6.withAlphaComponent(0.7)
        nameLabel.clipsToBounds = true
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        contentView.layer.cornerRadius = 10
    }
    
    // MARK: - Helper Functions
    
    func configure(recipe: Recipe) {
        imageView.image = recipe.image
        nameLabel.text = recipe.name
    }
    
    
    
}
