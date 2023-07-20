//
//  Door.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation
import RealmSwift


class ObjectImplementation: Object {
    
    @Persisted var id: Int = 0
    class func createRequest() -> URLRequest? { nil }
    
    static let cacher = try! Realm()
    
    static func getCachedItems() -> [ObjectImplementation] {
        var instList: [ObjectImplementation] = []
        let realm = try! Realm()
        let data = realm.objects(self)
        for item in data {
            instList.append(item)
        }
        return instList
    }
    
    
    static func writeNewItems(refresh: Bool, list: [ObjectImplementation]) {
        if refresh {
            let data = cacher.objects(self)
            do {
                try! cacher.write { cacher.delete(data) }
            }
        }
        for item in list {
            try! cacher.write { cacher.add(item) }
        }
    }
    
    static func getNetworkItems(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        NetworkService.makeRequest(request: createRequest()) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                completion(.success(json))
            }
        }
    }
    
    class func getJSONItem(_ data: [String: Any]) -> [ObjectImplementation] {
        return []
    }
    
    static func readItems(refresh: Bool, completionHandler: @escaping ([ObjectImplementation]) -> Void) {
        
        let cachedItems = getCachedItems()
        if (refresh || cachedItems.isEmpty) {
            getNetworkItems { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        let instList = getJSONItem(data)
                        writeNewItems(refresh: refresh, list: instList)
                        completionHandler(instList)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        } else {
            
            completionHandler(cachedItems)
        }
        
    }
}


