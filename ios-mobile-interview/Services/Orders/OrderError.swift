//
//  OrderError.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 29.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

enum OrderError: LocalizedError {
    case ordersUpdatingFailed(reasonError: Error?)
    
    
    // MARK: LocalizedError
    var errorDescription: String? {
        switch self {
        case .ordersUpdatingFailed(_):
            return "ordersUpdatingFailed".localized
        }
    }
}
