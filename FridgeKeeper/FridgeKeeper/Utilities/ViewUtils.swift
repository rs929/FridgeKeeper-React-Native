//
//  ViewUtils.swift
//  FridgeKeeper
//
//  Created by Richie Sun on 8/21/23.
//

import UIKit

extension UIView {
    
    func fadeOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5) {
            self.layer.opacity = 0
        } completion: { _ in
            completion()
        }
    }
    
    func addShadow(color: UIColor){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 2
        layer.shadowOffset = .zero
    }
    
}
