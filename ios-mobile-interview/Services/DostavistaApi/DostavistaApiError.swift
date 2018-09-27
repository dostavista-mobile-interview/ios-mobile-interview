//
//  DostavistaApiError.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 29.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

enum DostavistaApiError: Error {
    case unexpectedFormat(reasonError: Error?)
    case generalConectionError(reasonError: Error?)
}
