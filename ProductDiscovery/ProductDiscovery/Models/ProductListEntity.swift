//
//  ProductEntity.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductListEntity: BaseEntity {
    private(set) var result : ProductListResultEntity?
    private(set) var extra: ProductListExtraEntity?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        result <- map["result"]
        extra <- map["extra"]
    }
}

class ProductListResultEntity: BaseEntity {
    private(set) var products : [ProductItemEntity]?
    private(set) var keywords: [ProductListItemKeywordEntity]?
    private(set) var filters: [ProductListItemFilterEntity]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        products <- map["products"]
        keywords <- map["keywords"]
        filters <- map["filters"]
    }
}

class ProductListItemKeywordEntity: BaseEntity {
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
    
    }
}

class ProductListItemFilterEntity: BaseEntity {
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
    
    }
}




class ProductListExtraEntity: BaseEntity {
    private(set) var totalItems : NSInteger?
    private(set) var page: NSInteger?
    private(set) var pageSize: NSInteger?
    private(set) var priceRanges: [ProductListExtraPriceRangeEntity]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        totalItems <- map["totalItems"]
        page <- map["page"]
        pageSize <- map["pageSize"]
        priceRanges <- map["priceRanges"]
    }
}

class ProductListExtraPriceRangeEntity: BaseEntity {
    private(set) var maxPrice : NSInteger?
    private(set) var minPrice: NSInteger?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        maxPrice <- map["maxPrice"]
        minPrice <- map["minPrice"]
    }
}
