//
//  ProductItemEntity.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductItemEntity: BaseEntity {
    private(set) var name: NSString?
    private(set) var sku: NSString?
    private(set) var productStatus: [ProductStatus]?
    private(set) var images: [ProductImage]?
    private(set) var price: [Price]?
    private(set) var promotionPrices:[PromotionPrice]?
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        
    }
}

class ProductImage: BaseEntity {
    private(set) var url: NSString?
    private(set) var priority: NSInteger?
    private(set) var path: NSString?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        url <- map["url"]
        priority <- map["priority"]
        path <- map["path"]
    }
}

class Price: BaseEntity {
    private(set) var supplierSalePrice: NSInteger?
    private(set) var sellPrice: NSInteger?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        supplierSalePrice <- map["supplierSalePrice"]
        sellPrice <- map["sellPrice"]
    }
}


class PromotionPrice: BaseEntity {
    private(set) var channel: NSString?
    private(set) var terminal: NSString?
    private(set) var finalPrice: NSInteger?
    private(set) var promotionPrice: NSInteger?
    private(set) var bestPrice: NSInteger?
    private(set) var flashSalePrice: NSInteger?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        channel <- map["channel"]
        terminal <- map["terminal"]
        finalPrice <- map["finalPrice"]
        promotionPrice <- map["promotionPrice"]
        bestPrice <- map["flashSalePrice"]
        flashSalePrice <- map["flashSalePrice"]
    }
}

class ProductStatus: BaseEntity {
    private(set) var publish: Bool?
    private(set) var sale: NSString?

    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        publish <- map["publish"]
        sale <- map["sale"]
    }
}
