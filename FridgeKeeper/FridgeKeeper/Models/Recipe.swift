//
//  Recipe.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

enum RecipeTag: String {
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case keto = "Keto"
    case gf = "Gluten-Free"
    case df = "Dairy-Free"
    case nf = "Nut-Free"
}

struct Recipe {
    let name: String
    let cookTime: Float
    let servings: Int
    let description: String
    let image: UIImage?
    let url: URL?
    let ingredients: [Ingredient]
    let tags: [RecipeTag]
}
