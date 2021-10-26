//
//  BirthdayPerson.swift
//  BirthdayIphoneApp
//
//  Created by 宮崎　幹太郎 on 2021/10/26.
//

import RealmSwift

class BirthdayPerson: Object {
    @objc dynamic var id = 0
    
    @objc dynamic var month = 0
    @objc dynamic var day = 0
    @objc dynamic var name = ""
    
    @objc dynamic var gaveText = ""
    @objc dynamic var giveText = ""
    @objc dynamic var memo = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
