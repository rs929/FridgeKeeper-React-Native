//
//  FontUtils.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

enum FontWeight: String {
    case regular = "Regular"
    case semibold = "SemiBold"
    case bold = "Bold"
    case italic = "Italic"
    case medium = "Medium"
}

extension UIFont {
    
    static func customFont(of size: CGFloat, weight: FontWeight) -> UIFont? {
        var fontName = "Lora-\(weight)"
        return UIFont(name: fontName, size: size)
    }
    
}
