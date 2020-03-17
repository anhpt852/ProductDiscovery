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
    var name: String?
    var sku: String?
    var status: ProductStatus?
    var images: [ProductImage]?
    var price: Price?
    var promotionPrices:[PromotionPrice]?
    var attributeGroups:[ProductAttributes]?
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        name <- map["name"]
        sku <- map["sku"]
        status <- map["status"]
        images <- map["images"]
        price <- map["price"]
        promotionPrices <- map["promotionPrices"]
        attributeGroups <- map["attributeGroups"]
    }
}

class ProductImage: BaseEntity {
    private(set) var url: String?
    private(set) var priority: NSInteger?
    private(set) var path: String?
    
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
    private(set) var channel: String?
    private(set) var terminal: String?
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
    private(set) var sale: String?

    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        publish <- map["publish"]
        sale <- map["sale"]
    }
}

class ProductAttributes: BaseEntity {
    private(set) var id: NSInteger?
    private(set) var name: String?
    private(set) var value: String?
    private(set) var parentId: NSInteger?
    private(set) var priority: NSInteger?


    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        value <- map["value"]
        parentId <- map["parentId"]
        priority <- map["priority"]
    }
}
