//
//  RealmHelper.swift
//  sunrise
//
//  Created by reddys on 21/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class RealmHelper: NSObject {
    
    class func getUserResource() -> UserResource?
    {
        let realm = try! Realm()
        
        // Query Realm for all dogs less than 2 years old
        let array = realm.objects(UserResource.self)
        if array.count > 0
        {
            return array[0]
        }
        return nil
    }
    
}
