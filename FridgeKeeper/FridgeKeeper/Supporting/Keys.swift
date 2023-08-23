//
//  Keys.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import UIKit

class Keys {
    
    static let clientID = Keys.googleKeyDict["CLIENT_ID"] as? String ?? ""
    static let serviceClientID = Keys.keyDict["GOOGLE_CLIENT_SERVICE_ID"] as? String ?? ""
    static let GOOGLE_API_KEY = Keys.keyDict["GOOGLE_API"] as? String ?? ""
    static let INGREDIENTS_ID = "1c6gARC90oIslDCzsI8Kz87Ll_QOJKzMEq6e-Dk-Hm6w"
    
    private static let keyDict: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else { return [:] }
        return dict
    }()
    
    private static let googleKeyDict: NSDictionary = {
        guard let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) else { return [:] }
        return dict
    }()
}

