//
//  Recipes.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 10/9/23.
//

import Foundation
import UIKit

class RecipeExamples {
    
    static let recipes = [
        Recipe(name: "World's Best Lasagna", cookTime: 2.5, servings: 12, description: "This lasagna recipe takes a little work, but it is so satisfying and filling that it's worth it!", image: UIImage(named: "lasagna"), url: URL(string: "https://www.allrecipes.com/recipe/23600/worlds-best-lasagna/"), ingredients: [], tags: [.vegetarian]),
        Recipe(name: "Good Old-Fashioned Pancakes", cookTime: 0.5, servings: 8, description: "I found this pancake recipe in my Grandma's recipe book. Judging from the weathered look of this recipe card, this was a family favorite.", image: UIImage(named: "pancakes"), url: URL(string: "https://www.allrecipes.com/recipe/21014/good-old-fashioned-pancakes/"), ingredients: [], tags: [.df, .vegetarian]),
        Recipe(name: "Salted Pumpkin Caramels", cookTime: 1, servings: 10, description: "Making your own homemade salted pumpkin caramels is much easier than you would think. Scooping out a pumpkin and carving a jack-o-lantern is much harder! If you've never made caramel candy, this recipe is a great place to start.", image: UIImage(named: "caramels"), url: URL(string: "https://www.allrecipes.com/salted-pumpkin-caramels-recipe-8347647"), ingredients: [], tags: [.df, .gf, .vegan]),
        Recipe(name: "Chop Suey", cookTime: 0.5, servings: 4, description: "Chop suey is a colorful and flavorful Chinese American classic that can be prepared with ingredients you already have lying around. It’s a quick and easy stir fry perfect for a weeknight dinner.", image: UIImage(named: "chopSuey"), url: URL(string: "https://www.allrecipes.com/salted-pumpkin-caramels-recipe-8347647"), ingredients: [], tags: [.df, .gf, .nf]),
        Recipe(name: "Vegan Brownies", cookTime: 1, servings: 12, description: "These rich and fudgy vegan brownies are so good, you’ll never miss the eggs or dairy! This is also a gluten-free brownie recipe for those looking for gluten-free dessert options. The best part? You only need one bowl to make them!", image: UIImage(named: "brownies"), url: URL(string: "https://www.allrecipes.com/salted-pumpkin-caramels-recipe-8347647"), ingredients: [], tags: [.df, .nf, .vegan]),
    ]
}
