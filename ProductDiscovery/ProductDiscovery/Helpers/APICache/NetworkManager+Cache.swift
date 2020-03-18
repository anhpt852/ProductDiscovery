//
//  NetworkManager+Cache.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper
import Alamofire

extension NetworkManager {
    func getAPICache(withURL url: String,
                     withParam params: [String : AnyObject]?,
                     rawData data: Any?,
                     class clazz: AnyClass,
                     withMethod method: HTTPMethod,
                     withCacheEnable cacheEnable: Bool,
                     withCacheOnlyOption cacheOnly: Bool,
                     onComplete completion: @escaping (_ error: Error?, _ response: Any?) -> Void) {
        if cacheEnable {
            objectFromAPICache(withURL: url, withParam: params, data: data, class: clazz, withMethod: method, withCompletionBlock: { error, cache in
                completion(error, cache)
            })
        }
    }

    func handleAPIResult(withURL url: String?,
                         withParam params: [String : AnyObject]?,
                         withRawData data: Any?,
                         withMethod method: HTTPMethod,
                         withResponseObject responseObject: Any?,
                         withResponseJson responseJson: Any?,
                         withCacheEnable cacheEnable: Bool,
                         withCompletionBlock apiResultHandler: @escaping (_ error: Error?, _ response: Any?) -> Void) {
        apiResultHandler(nil, responseObject)
        if cacheEnable && responseJson != nil && ((responseJson as? [String : AnyObject])?["error_code"] as? NSNumber)?.intValue ?? 0 == 0 {
            saveApiCacheInThread(withDictionary: (responseJson as! [String : AnyObject]), withParam: params, withRawData: data, withURL: url, withMethod: method)
        }
    }
    
    func objectFromAPICache(withURL apiURL: String?,
                            withParam params: [String : AnyObject]?,
                            data: Any?, class clazz: AnyClass,
                            withMethod method: HTTPMethod,
                            withCompletionBlock handler: @escaping (_ error: Error?, _ response: Any?) -> Void) {
        let apiResult = getApiJsonDataFromCache(withURL: apiURL, withParam: params, withRawData: data, withMethod: method)
        let response = parseResponseObject(apiResult, String(describing: clazz.self))
        handler(nil, response)
    }
    
    func getApiJsonDataFromCache(withURL apiURL: String?,
                                 withParam params: [String : AnyObject]?,
                                 withRawData data: Any?,
                                 withMethod method: HTTPMethod) -> [String : AnyObject]? {
        let apiCache = getAPICache(withURL: apiURL, withParam: params, withRawData: data, withMethod: method)
        if let tmpData = apiCache?.data {
            do {
                let output = try JSONSerialization.jsonObject(with: tmpData.data(using: .utf8)!, options: .allowFragments) as? [String:AnyObject]
                return output
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func saveApiCacheInThread(withDictionary jsonData: [String : AnyObject]?,
                              withParam params: [String : AnyObject]?,
                              withRawData data: Any?,
                              withURL url: String?,
                              withMethod method: HTTPMethod?) {
        if jsonData == nil {
            return
        }
        
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: jsonData!, options: .prettyPrinted)
        
        DispatchQueue.global(qos: .default).async(execute: {
            // Store api data

            var apiCache = self.getAPICache(withURL: url, withParam: params, withRawData: data, withMethod: method)
            do {
                let realm = try Realm()
                if let _apiCache = apiCache {
                    try! realm.write {
                        realm.delete(_apiCache)
                    }
                }

            } catch let error as NSError {
                print("error - \(error.localizedDescription)")
            }
            
            do {
                let realm = try Realm()
                apiCache = CacheAPIData()
                apiCache?.url = url
                apiCache?.method = method?.rawValue
                apiCache?.param = self.archiveNSData(fromJSON: params, withKey: "param")
                apiCache?.data = String.init(data: jsonData, encoding: .utf8)
                if let apiCache = apiCache {
                    try! realm.write {
                        realm.add(apiCache, update: .all)
                    }
                }

            } catch let error as NSError {
                print("error - \(error.localizedDescription)")
            }
            // apiCache.access_token = [UserTracker sharedInstance].gamotaAccessToken;
    
            
        })
    }

    func getAPICache(withURL apiURL: String?,
                     withParam params: [String : AnyObject]?,
                     withRawData data: Any?,
                     withMethod method: HTTPMethod?) -> CacheAPIData? {
        
        let realm = try! Realm()

        let predicate = NSPredicate(format: "url == %@",apiURL!)
        let cacheData = realm.objects(CacheAPIData.self).filter(predicate).first

        if let _cacheData = cacheData  {
            var paramData: [String : AnyObject]?
            if (_cacheData.param != nil) {
                let unarchiver = try! NSKeyedUnarchiver.init(forReadingFrom: _cacheData.param!)
                paramData = unarchiver.decodeObject(forKey: "param") as? [String : AnyObject]
            }
            if ((paramData as NSDictionary?)?.isEqual(params) ?? false || (paramData == nil && params == nil)) && (method?.rawValue == _cacheData.method) {
                return _cacheData
            }

        }
        return nil
    }
    
    func archiveNSData(fromJSON jsonData: [String : AnyObject]?, withKey key: String?) -> Data? {
        if jsonData == nil {
            return nil
        }
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        archiver.encode(jsonData, forKey: key ?? "")
        let data = archiver.encodedData
        archiver.finishEncoding()

        return data
    }
    

    func parseResponseObject(_ responseObject: Any?, _ clazz: String?) -> Any? {
        if responseObject == nil {
            return nil
        }
        if clazz == nil {
            return responseObject
        }
       
        var response: Any? = nil
        let jsonData: Data = try! JSONSerialization.data(withJSONObject: responseObject!, options: .prettyPrinted)
        
        
        if clazz == String(describing: ProductListEntity.self){
            response = Mapper<ProductListEntity>().map(JSONString: String.init(data: jsonData, encoding: .utf8)!)
        } else if clazz == String(describing: ProductDetailEntity.self){
            response = Mapper<ProductDetailEntity>().map(JSONString: String.init(data: jsonData, encoding: .utf8)!)
        } else {
          response = responseObject
        }

        return response ?? responseObject
    }
}
