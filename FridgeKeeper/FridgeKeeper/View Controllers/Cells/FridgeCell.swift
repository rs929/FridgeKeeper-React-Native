//
//  FridgeCell.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

class FridgeCell: UICollectionViewCell {
    
    // MARK: - Views
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let quantityLabel = UILabel()
    private let typeLabel = UILabel()
    
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
        imageView.tintColor = .systemGreen
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(100)
        }
        
        nameLabel.font = .customFont(of: 16, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        typeLabel.font = .customFont(of: 14, weight: .regular)
        typeLabel.textColor = .systemGray
        
        contentView.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
    
    func configure(ingredient: Ingredient) {
        nameLabel.text = ingredient.name
        typeLabel.text = ingredient.type.rawValue
        quantityLabel.text = "\(ingredient.quantity)"
    }
}
