//
//  String+Localized.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        let result = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        
        if result.isEmpty {
            return self
        }
        
        return result
    }
}
