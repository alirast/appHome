//
//  APIManager.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation

class APIManager {
    
    enum ManagerMethod {
        case door
        case camera
    }
    
    class func getBaseURL(method: ManagerMethod) -> String {
        switch method {
        case .door, .camera:
            return "https://cars.cprogroup.ru/api/rubetek"
        }
    }
    
    class func getHTTPMethod(_ method: ManagerMethod) -> String {
        switch method {
        case .door, .camera:
            return "GET"
        }
    }
    
    class func getSpecialMethod(_ method: ManagerMethod) -> String {
        switch method {
        case .door:
            return "/doors/"
        case .camera:
            return "/cameras/"
        }
    }
    
    static func createRequest(_ method: ManagerMethod) -> URLRequest? {
        let urlString = getBaseURL(method: method) + getSpecialMethod(method)
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = getHTTPMethod(method)
        return request
    }
}
