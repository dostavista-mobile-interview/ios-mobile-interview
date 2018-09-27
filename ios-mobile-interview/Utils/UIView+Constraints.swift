//
//  UIView+Constraints.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 29.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import UIKit

extension UIView {
    func constraintsToEdges(on parentView: UIView, insets: UIEdgeInsets? = nil) {
        let insets = insets ?? .zero
        
        self.topAnchor.constraint(
            equalTo: parentView.topAnchor,
            constant: insets.top
            ).isActive = true
        
        self.bottomAnchor.constraint(
            equalTo: parentView.bottomAnchor,
            constant: -insets.bottom
            ).isActive = true
        
        self.leadingAnchor.constraint(
            equalTo: parentView.leadingAnchor,
            constant: insets.left
            ).isActive = true
        
        self.trailingAnchor.constraint(
            equalTo: parentView.trailingAnchor,
            constant: -insets.right
            ).isActive = true
    }
}
