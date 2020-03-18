//
//  NetworkManager.swift
//  Vatgia-iOS-For-Merchant
//
//  Created by Phan Tuan Anh on 11/17/16.
//  Copyright © 2016 Tuan Anh Phan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


struct APIBaseURL {

    static let API_BASE_URL = "https://listing.stage.tekoapis.net/api/";
    
}

struct APIPath {
    static let search = "search/?channel=pv_showroom&visitorId=&terminal=CP01"
    static let detail = "products/{0}?channel=pv_showroom&terminal=CP01"
}


class NetworkManager: Session {
    static let sharedManager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 30.0
        
        return NetworkManager(configuration: configuration)
    }()
    
    
    // 1. Get List Product
    func getListProduct(_ page:Int, _ keyword:String, _
                        completion: @escaping (_ result:AFResult<ProductListEntity> ) -> Void,
                        cacheCompletion:@escaping (_ error: Error?, _ response: Any?) -> Void) {
        var path = APIBaseURL.API_BASE_URL + APIPath.search + "&_page=" + "\(page)"
        if keyword.count > 0 {
            path += "&q=" + keyword
        }
        
        self.startRequest(withURL: path, withParam: nil, rawData: nil, class: ProductListEntity.self, withMethod: .get, withCache: true, withCacheOnly: false, onComplete: completion, cacheCompletion:cacheCompletion)
//        self.requestWithMethod(.get, fullUrl: path, params: nil, completion: completion)
    }
    
    // 1. Get Product Detail
    func getDetailProduct(_ sku: String, _
                            completion: @escaping (_ result:AFResult<ProductDetailEntity> ) -> Void,
                            cacheCompletion:@escaping (_ error: Error?, _ response: Any?) -> Void) {
        let path = APIBaseURL.API_BASE_URL + APIPath.detail.replacingOccurrences(of: "{0}", with: sku)
        
        self.startRequest(withURL: path, withParam: nil, rawData: nil, class: ProductDetailEntity.self, withMethod: .get, withCache: true, withCacheOnly: false, onComplete: completion, cacheCompletion:cacheCompletion)
//        self.requestWithMethod(.get, fullUrl: path, params: nil, completion: completion)
    }

    
    
    // MARK: Private
    func startRequest<T:BaseEntity>(withURL url: String,
                      withParam params: [String : AnyObject]?,
                      rawData data: Any?,
                      class clazz: AnyClass,
                      withMethod method: HTTPMethod,
                      withCache cacheEnable: Bool,
                      withCacheOnly cacheOnly: Bool,
                      onComplete completion: @escaping (_ result: AFResult<T>) -> Void,
                      cacheCompletion:@escaping (_ error: Error?, _ response: Any?) -> Void)
    {
        self.getAPICache(withURL: url, withParam: params, rawData: nil, class: clazz, withMethod: method, withCacheEnable: true, withCacheOnlyOption: false) { (error, rep) in
            cacheCompletion(error,rep)
            self.requestWithMethod(method, fullUrl: url, params: params, encoding: Alamofire.URLEncoding.default, completion: completion)
        }
        
        
    }
    
    fileprivate func requestWithMethod<T:BaseEntity>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, completion: @escaping (_ result: AFResult<T>) -> Void) {
        
        
        self.requestWithMethod(method, fullUrl: fullUrl, params: params, encoding: Alamofire.URLEncoding.default, completion: completion)
    }
    
    fileprivate func requestByUploadData<T:BaseEntity>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, images: [UIImage]?, completion: @escaping (_ result: AFResult<T>) -> Void) {
  
        return self.uploadWithMethod(method, fullUrl: fullUrl, params: params, images: images, completion: completion)
    }
    
    fileprivate func requestWithMethod<T:BaseEntity>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, encoding: ParameterEncoding, completion: @escaping (_ result: AFResult<T>) -> Void) {
        let url = URL(string: fullUrl)
        if let url = url {
            self.request(url, method: method, parameters: params, encoding: encoding, headers: nil)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json","text/html"])
                .responseObject(completionHandler: { (response: AFDataResponse<T>) in
                    switch response.result {
                    case .success(let value):
                        do {
                            let tmpValue = try response.result.get()
                            self.saveApiCacheInThread(withDictionary: tmpValue.toJSON() as [String : AnyObject], withParam: params, withRawData: nil, withURL: fullUrl, withMethod: .get)
                            completion(response.result) // Return result only
                            debugPrint(value)
                        }
                        catch let error as NSError {
                            print("error - \(error.localizedDescription)")
                        }

                        break
                    case .failure(let error):
                        debugPrint("HTTP request error \(String(describing: error.localizedDescription))")
                        if let statusCode = response.response?.statusCode {
                            let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                            debugPrint("HTTP response error with message " + errorMessage)
                        }
                    }
                    
            })
        }
    }
    
    fileprivate func uploadWithMethod<T:BaseEntity>(_ method: HTTPMethod, fullUrl: String, params: [String : AnyObject]?, images: [UIImage]?, completion: @escaping (_ result: AFResult<T>) -> Void) {
        let url = URL(string: fullUrl)
        if url != nil {
            self.upload(multipartFormData: { (formData) in
                if let params = params {
                    for (key, value) in params {
                        if let value = value as? String { // String value
                            if let data = value.data(using: String.Encoding.utf8) {
                                formData.append(data, withName: key)
                            }
                        } else if value is NSNumber { // NSNumber value
                            if let data = "\(value)".data(using: String.Encoding.utf8){
                                formData.append(data, withName: key)
                            }
                        }
                    }
                }
                for image in images! {
                    if let imageData = image.jpegData(compressionQuality: 0.6) {
                        formData.append(imageData, withName: "image", mimeType: "image/jpeg")
                    }
                }
                debugPrint(formData.contentType)
            }, to: fullUrl).responseObject {(response:AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                   completion(response.result) // Return result only
                   debugPrint(value)
                    break
                case .failure(let error):
                    debugPrint("HTTP request error \(String(describing: error.localizedDescription))")
                    if let statusCode = response.response?.statusCode {
                        let errorMessage = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                        debugPrint("HTTP response error with message " + errorMessage)
                    }
                }
            }
        }
    }
}
