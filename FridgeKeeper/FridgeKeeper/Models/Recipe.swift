//
//  Recipe.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import Foundation

struct Recipe {
    let name: String
    let cookTime: String?
    let image: URL?
    let url: URL?
    let ingredients: [Ingredient]
}
