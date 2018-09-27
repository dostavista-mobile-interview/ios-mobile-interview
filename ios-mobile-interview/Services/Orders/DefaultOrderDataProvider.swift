//
//  DefaultOrderDataProvider.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

final class DefaultOrderDataProvider: OrderDataProvider {
    // // MARK: Dependencies
    fileprivate let dostavistaApiClient: DostavistaApiClient
    
    fileprivate static let iso8601DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    
    // MARK: Init
    init(dostavistaApiClient: DostavistaApiClient) {
        self.dostavistaApiClient = dostavistaApiClient
    }
    
    
    // MARK: Private
    fileprivate var savedOrders = [Order]()
    
    
    // MARK: OrderDataProvider
    func getOrders() -> [Order] {
        return savedOrders
    }
    
    func updateOrders(completion: @escaping (OrderError?) -> ()) {
        dostavistaApiClient.updateOrders { [weak self] responseDto in
            guard let strongSelf = self else { return }
            
            if let error = responseDto.error {
                completion(OrderError.ordersUpdatingFailed(reasonError: error))
                return
            }
            
            guard
                let data = responseDto.data,
                let ordersArray = data["orders"] as? [[String : Any]] else
            {
                completion(OrderError.ordersUpdatingFailed(reasonError: nil))
                return
            }
            
            var fetchedOrders = [Order]()
            for eachOrderDictionary in ordersArray {
                guard
                    let orderId = eachOrderDictionary["order_id"] as? Int,
                    let address = eachOrderDictionary["address"] as? String,
                    let dateString = eachOrderDictionary["date"] as? String,
                    let date = DefaultOrderDataProvider.iso8601DateFormatter.date(from: dateString) else
                {
                    // ignore unexpected orders
                    // TODO: Add logging and track error
                    continue
                }
                
                // text is optional
                let text = eachOrderDictionary["text"] as? String
                
                let order = Order(
                    orderId: orderId,
                    address: address,
                    date: date,
                    text: text
                )
                fetchedOrders.append(order)
            }
        
            strongSelf.savedOrders = fetchedOrders
            completion(nil)
        }
    }
}
