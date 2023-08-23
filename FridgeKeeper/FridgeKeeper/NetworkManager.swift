//
//  NetworkManager.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/22/23.
//

import Alamofire
import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let sheetsService = GTLRSheetsService()
    
    func getAllIngredients(completion: @escaping (Result<GTLRSheets_Spreadsheet?, Error>) -> Void) {
        let signInConfig = GIDConfiguration.init(clientID: Keys.clientID)
        GIDSignIn.sharedInstance.configuration = signInConfig
        
        sheetsService.apiKey = Keys.GOOGLE_API_KEY
        sheetsService.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer
        
        let spreadsheetId = Keys.INGREDIENTS_ID
        let query = GTLRSheetsQuery_SpreadsheetsGet.query(withSpreadsheetId: spreadsheetId)
        
        sheetsService.executeQuery(query) { (ticket, result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let result = result as? GTLRSheets_Spreadsheet
                let sheets = result?.sheets
                if let sheetInfo = sheets {
                    for info in sheetInfo {
                        print("New sheet found: \(String(describing: info.properties?.title))")
                    }
                }
                
                completion(.success(result))
            }
        }
    }
    
}

