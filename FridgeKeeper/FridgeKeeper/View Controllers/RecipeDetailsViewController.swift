//
//  RecipeDetailsViewController.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 10/9/23.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    // MARK: - Data
    
    private let recipe: Recipe
    
    // MARK: - Views
    
    private let recipeImageView = UIImageView()
    private let recipeNameLabel = UILabel()
    private let recipePercentLabel = UILabel()
    private let recipeDescriptionLabel = UILabel()
    private let recipeInstructionsLabel = UILabel()
    private let recipeInfoStackView = UIStackView()
    
    
    private let recipeTimeLabel = IconLabel(systemImage: "clock")
    private let recipeServingsLabel = IconLabel(systemImage: "fork.knife")
    private let recipeURLLabel = IconLabel(systemImage: "link")
    private let recipeTagsLabel = IconLabel(systemImage: "tag")
    
    private let recipeInstructionsTextView = UITextView()
    
    private let scrollView = UIScrollView()
    
    // MARK: - Initialziers
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        setupHeading()
        setupRecipeInfoStackView()
        updateRecipeInfo()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureScrollView()
    }
    
    // MARK: - Setup Views
    
    private func configureScrollView() {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentRect.height)
    }
    
    private func setupScrollView() {
        scrollView.isScrollEnabled = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupHeading() {
        recipeNameLabel.font = .customFont(of: 24, weight: .bold)
        recipeNameLabel.numberOfLines = 0
        recipeNameLabel.textColor = .black
        scrollView.addSubview(recipeNameLabel)
        
        recipeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(20)
        }
        
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.layer.cornerRadius = 10
        scrollView.addSubview(recipeImageView)
        
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(recipeNameLabel)
            make.height.equalTo(200)
        }
    }
    
    private func setupRecipeInfoStackView() {
        recipeInfoStackView.alignment = .leading
        recipeInfoStackView.axis = .vertical
        recipeInfoStackView.distribution = .fill
        recipeInfoStackView.spacing = 20
        scrollView.addSubview(recipeInfoStackView)
        
        recipeInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(recipeNameLabel)
        }
        
        recipeDescriptionLabel.font = .customFont(of: 16, weight: .regular)
        recipeDescriptionLabel.numberOfLines = 0
        recipeDescriptionLabel.textColor = .black
        recipeInfoStackView.addArrangedSubview(recipeDescriptionLabel)
        
        recipeDescriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        [recipeTimeLabel, recipeServingsLabel, recipeURLLabel, recipeTagsLabel].forEach { label in
            recipeInfoStackView.addArrangedSubview(label)
            
            label.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func updateRecipeInfo() {
        recipeNameLabel.text = recipe.name
        recipeTimeLabel.setText(text: "Cook Time: \(recipe.cookTime) hours")
        recipeServingsLabel.setText(text: "Servings: \(recipe.servings)")
        recipeImageView.image = recipe.image
        if let url = recipe.url {
            recipeURLLabel.setAttributedText(text: "Link to recipe here", url: url)
        } else {
            recipeURLLabel.setText(text: "No link availible")
        }
        
        if recipe.tags.count == 0 {
            recipeTagsLabel.isHidden = true
        }
        
        recipeTagsLabel.setText(text: listToString(tags: recipe.tags))
        recipeDescriptionLabel.text = recipe.description
    }
    
    private func listToString(tags: [RecipeTag]) -> String {
        let str = NSMutableString()
        for i in 0...tags.count - 1 {
            if i == tags.count - 1 {
                str.append("\(tags[i].rawValue)")
            } else {
                str.append("\(tags[i].rawValue), ")
            }
        }
        
        return str as String
    }
    
}
