//
//  NetworkService.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation

class NetworkService {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    static func makeRequest(request: URLRequest?, completion: @escaping (Data?, URLResponse?, Error?) -> Void)  {
        guard let request = request else { return }
        
        URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
    }
}
