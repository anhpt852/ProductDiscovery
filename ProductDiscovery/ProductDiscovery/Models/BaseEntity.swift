//
//  EntityBase.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/1/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseEntity: Mappable {
    private(set) var code: NSInteger?

    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        code <- map["code"];
    }
}
