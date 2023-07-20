//
//  Door.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation
import RealmSwift

class Door: ObjectRealization {
    
    override class func createRequest() -> URLRequest? {
        return APIManager.createRequest(.door)
    }
    
    override class func getJSONItem(_ data: [String : Any]) -> [ObjectImplementation] {
        var doorList: [Door] = []
        if let doors = data["data"] as? [[String: Any]] {
            for item in doors {
                if let favorites = item["favorites"] as? Bool, let name = item["name"] as? String, let id = item["id"] as? Int {
                    let snapshot = item["snapshot"] as? String
                    let room = item["room"] as? String
                    let door = Door()
                    door.id = id
                    door.snapshot = snapshot
                    door.room = room
                    door.name = name
                    door.favorites = favorites
                    
                    doorList.append(door)
                }
            }
        }
        return doorList
    }
    
    override func getFavourite() {
        let realm = try! Realm()
        if let door = realm.objects(Door.self).filter("id == \(id)").first {
            try! realm.write {
                door.favorites = !door.favorites
            }
        }
    }
    
    override func changeName(_ newName: String) {
        let realm = try! Realm()
        if let door = realm.objects(Door.self).filter("id == \(id)").first {
            try! realm.write {
                door.name = newName
            }
        }
    }
}
