//
//  RealmManager.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import Foundation
import RealmSwift

class RealmStorageManager {
    private static let realm = try! Realm()
    private init() { }
    
    /// save object to realm
    /// - Parameter object: any model that confirm to Object
    static func setObject(_ object: Object) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    /// update object to realm
    /// - Parameter object: update any model that confirm to Object
    static func setObjectsList(_ objects: [Object]) {
        try? realm.write {
            realm.add(objects, update: .modified)
        }
    }
    
    static func deleteObjectsList(_ objects: [Object]) {
        try? realm.write {
            realm.delete(objects)
        }
    }
    
    /// retreve objects from realm
    /// - Returns: array of objects
    static func getObjects<T: Object>(_ model: T.Type, completion: (([T]) -> ())) {
        let objects = realm.objects(model)
        var accumulate: [T] = [T]()
        for object in objects {
            accumulate.append(object)
        }
        completion(accumulate)
    }
    
    /// delete object from realm
    /// - Parameter object: object that will be deleted
    static func deleteObject(_ object: Object){
        try? realm.write{
            realm.delete(object)
        }
    }
}
