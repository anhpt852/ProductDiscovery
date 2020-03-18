//
//  APICacheManager.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import RealmSwift

class APICacheManager: Object {
    
    func clearAllCache(){
        do {
            let realm = try Realm()
            try! realm.write {
                realm.deleteAll()
            }

        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
    }
    
    
    func clearCacheWithURLString(_ urlString:String) {
        do {
            let realm = try Realm()
            let object = realm.objects(CacheAPIData.self).filter("url = %@",urlString).first
            try! realm.write {
                if let obj = object {
                    realm.delete(obj)
                }
            }
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
       
        
        
    }
}
