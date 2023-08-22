//
//  Ingredient.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import Foundation

enum IngredientType: String {
    case fruit = "Fruit"
    case vegetable = "Vegetable"
    case protein = "Protein"
    case dairy = "Dairy"
    case grain = "Grain"
    case spiceOrCondiment = "Spice/Condiment"
    case other = "Other"
}

struct Ingredient {
    let name: String
    var quantity: Int?
    let image: URL?
    let type: IngredientType
    
}
