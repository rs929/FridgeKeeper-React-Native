//
//  Keys.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

class Keys {
    
    static let GOOGLE_API_KEY = Keys.keyDict["GOOGLE_API"] as? String ?? ""
    static let INGREDIENTS_ID = "1c6gARC90oIslDCzsI8Kz87Ll_QOJKzMEq6e"
    
    private static let keyDict: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else { return [:] }
        return dict
    }()
}

