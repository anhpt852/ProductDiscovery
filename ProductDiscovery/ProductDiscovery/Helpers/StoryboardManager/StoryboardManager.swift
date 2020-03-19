//
//  APICacheManager.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//


import UIKit

class StoryboardManager: NSObject {
    
    var storyboard:UIStoryboard?
    
    static let mainManager: StoryboardManager = {
        let instance = StoryboardManager.init(storyboardName: "Main")
        return instance
    }()
    
    
    // MARK: - constructor

    convenience init(storyboardName:NSString){
        self.init()
        storyboard = UIStoryboard.init(name: storyboardName as String, bundle: nil)
    }
    
    // MARK: - destructor
    
    // MARK: - public class methods
    
    // MARK: - private class methods
    
    // MARK: - override/overload
    
    // MARK: - public instance methods
    func instantiateViewControllerWithIdentifier(identifier:NSString) -> UIViewController  {
        return (storyboard?.instantiateViewController(withIdentifier: identifier as String))!
    }
    // MARK: - private instance methods
    
    // MARK: - public get/set methods
    
    // MARK: - private get/set methods
    
    // MARK: - public action methods
    
    // MARK: - private action methods
    
    // MARK: - delegate methods
}
