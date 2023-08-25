//
//  CustomSearchBar.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/24/23.
//

import UIKit

class CustomSearchBar: UIView {
    
    private let contentView = UIView()
    let searchTextField = UITextField()
    private let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
    
    func setup(placeholder: String) {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 10
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(4)
        }
        
        searchImageView.tintColor = self.tintColor
        searchImageView.contentMode = .scaleAspectFit
        contentView.addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        searchTextField.placeholder = placeholder
        searchTextField.isUserInteractionEnabled = true
        contentView.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(searchImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
        }
    }
    
}
