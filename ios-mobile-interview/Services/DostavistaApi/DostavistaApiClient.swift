//
//  DostavistaApiClient.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

protocol DostavistaApiClient: class {
    func updateOrders(completion: @escaping (DostavistaApiResponseDto) -> ())
}
