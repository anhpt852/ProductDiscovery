//
//  ProductDetailEntity.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductDetailEntity: BaseEntity {
    private(set) var result : ProductDetailResultEntity?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        result <- map["result"]
    }
}

class ProductDetailResultEntity: BaseEntity {
    private(set) var product : ProductItemEntity?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        product <- map["product"]
    }
}

