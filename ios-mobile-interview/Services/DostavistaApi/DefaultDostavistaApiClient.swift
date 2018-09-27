//
//  DefaultDostavistaApiClient.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import Foundation

final class DefaultDostavistaApiClient: DostavistaApiClient {
    fileprivate let sessionConfiguration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpCookieStorage = nil
        configuration.timeoutIntervalForRequest = 30
        
        return configuration
    }()
    
    fileprivate let session: URLSession
    
    
    // MARK: Init
    init() {
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    
    // MARK: DostavistaApiClient
    func updateOrders(completion: @escaping (DostavistaApiResponseDto) -> ()) {
        let request = URLRequest(url: URL(string: "https://devtools.dostavista.ru/mobile-interview-api.php?limit=10")!)
        
        let task = session.dataTask(with: request) { (taskData, taskResponse, taskError) in
            var error: Error?
            var dataDictionary = [String : Any]()
            
            if let taskError = taskError {
                error = DostavistaApiError.generalConectionError(reasonError: taskError)
            } else if let taskData = taskData {
                do {
                    let json = try JSONSerialization.jsonObject(with: taskData, options: .allowFragments)
                    if let jsonDictionary = json as? [String : Any] {
                        dataDictionary = jsonDictionary
                    } else {
                        error = DostavistaApiError.unexpectedFormat(reasonError: nil)
                    }
                } catch(let serializationError) {
                    error = DostavistaApiError.unexpectedFormat(reasonError: serializationError)
                }
            }
            
            DispatchQueue.main.async {
                let responseDto = DostavistaApiResponseDto(
                    error: error,
                    data: dataDictionary
                )
                completion(responseDto)
            }
        }
        
        task.resume()
    }
}
