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
    static let search = "search/?channel=pv_showroom&visitorId=&q=&terminal=CP01"
}


class NetworkManager: Session {
    static let sharedManager: NetworkManager = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 30.0
        
        return NetworkManager(configuration: configuration)
    }()
    
    
    // 1. Login
    func getListProduct(_ completion: @escaping (_ result:AFResult<ProductListEntity> ) -> Void) {
        let path = APIBaseURL.API_BASE_URL + APIPath.search
        
        self.requestWithMethod(.get, fullUrl: path, params: nil, completion: completion)
    }
    
    

    
    // MARK: Private
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
