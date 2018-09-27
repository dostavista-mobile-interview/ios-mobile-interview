//
//  OrderDataProvider.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

protocol OrderDataProvider: class {
    func getOrders() -> [Order]
    func updateOrders(completion: @escaping (OrderError?) -> ())
}
