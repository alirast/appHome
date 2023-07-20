//
//  WorkInstance.swift
//  appHome
//
//  Created by N S on 19.07.2023.
//

import Foundation
import RealmSwift

class ObjectRealization: ObjectImplementation {
    
    //will be managed by realm
    @Persisted var name: String = ""
    @Persisted var snapshot: String? = nil
    @Persisted var favorites: Bool = false
    @Persisted var room: String? = nil
    
    public func getFavourite() {
        do {
            try! ObjectRealization.cacher.write { [weak self] in
                guard let favorites = self?.favorites else { return }
                self?.favorites = !favorites
            }
        }
    }
    
    public func changeName(_ newName: String) {
        do {
            try! ObjectRealization.cacher.write { [weak self] in
                self?.name = newName
            }
        }
    }
}
