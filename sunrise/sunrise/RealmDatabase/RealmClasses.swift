//
//  RealmClasses.swift
//  sunrise
//
//  Created by reddys on 21/10/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class UserResource: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
    @objc dynamic var forename = ""
    @objc dynamic var lastname = ""
    @objc dynamic var username = ""
    @objc dynamic var birthday = ""
}



class product: Object {
    @objc dynamic var email = ""
    @objc dynamic var firstName = ""
}




