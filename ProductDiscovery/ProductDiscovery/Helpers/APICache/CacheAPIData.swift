//
//  CacheAPIData.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class CacheAPIData: Object {
    @objc dynamic var id = 0
    @objc dynamic var data:String? = nil
    @objc dynamic var date_modified:Date? = nil
    @objc dynamic var method:String? = nil
    @objc dynamic var param:Data? = nil
    @objc dynamic var url:String? = nil
    @objc dynamic var access_token:String? = nil
    
    override class func primaryKey() -> String? {
        return "url"
    }
}
