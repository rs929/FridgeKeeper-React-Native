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

enum Unit: String {
    case milliliter = "mL"
    case liter = "L"
    case milligram = "mg"
    case gram = "g"
    
    case fluidOunce = "fl oz"
    case teaspoon = "tsp"
    case tablespoon = "tbsp"
    case cup = "cup"
    case pint = "pint"
    case quart = "qt"
    case ounce = "oz"
    case pound = "lb"
    
    case count = "ct"
}

struct UnitQuantity {
    let quantity: Float
    let unit: Unit
}

struct Ingredient {
    let name: String
    var quantity: Int?
    let image: URL?
    let type: IngredientType
}
