//
//  Camera.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation
import RealmSwift


class Camera: ObjectRealization {
    
    @Persisted var record: Bool = false

    override class func createRequest() -> URLRequest? {
        return APIManager.createRequest(.camera)
    }
    
    override class func getJSONItem(_ data: [String : Any]) -> [ObjectImplementation] {
        var cameraList: [Camera] = []
        if let jsonData = data["data"] as? [String: Any], let cameras = jsonData["cameras"] as? [[String: Any]] {
            for item in cameras {
                
                if let snapshot = item["snapshot"] as? String, let favorites = item["favorites"] as? Bool, let name = item["name"] as? String, let id = item["id"] as? Int, let rec = item["rec"] as? Bool {
                    
                    let room = item["room"] as? String
                    let camera = Camera()
                    camera.id = id
                    camera.record = rec
                    camera.room = room
                    camera.snapshot = snapshot
                    camera.favorites = favorites
                    camera.name = name
                    
                    cameraList.append(camera)
                }
            }
        }
        return cameraList
    }
    
    override func getFavourite() {
        let realm = try! Realm()
        if let camera = realm.objects(Camera.self).filter("id == \(id)").first {
            try! realm.write {
                camera.favorites = !camera.favorites
            }
        }
    }
    
    override func changeName(_ newName: String) {
        let realm = try! Realm()
        if let camera = realm.objects(Camera.self).filter("id == \(id)").first {
            try! realm.write {
                camera.name = newName
            }
        }

    }
}
