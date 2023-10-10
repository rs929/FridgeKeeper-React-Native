//
//  IconLabel.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 10/9/23.
//

import UIKit

class IconLabel: UIView {
    
    // MARK: - Views
    
    private let iconImageView = UIImageView()
    private let label = UILabel()
    
    // MARK: - Initialziers
    
    init(systemImage: String, image: UIImage? = nil) {
        super.init(frame: CGRect())
        
        if let customImage = image {
            iconImageView.image = customImage
        } else {
            iconImageView.image = UIImage(systemName: systemImage)
        }
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .black
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        label.font = UIFont.customFont(of: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(5)
        }
    }
    
    // MARK: - Helper Functions
    
    func setText(text: String) {
        label.text = text
    }
    
    func setAttributedText(text: String, url: URL) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.link, value: url.absoluteString, range: NSRange(location: 0, length: text.count))
        label.attributedText = attributedString
    }
    
}
