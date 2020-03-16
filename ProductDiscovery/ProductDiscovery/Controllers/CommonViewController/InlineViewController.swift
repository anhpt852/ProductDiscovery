//
//  InlineViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

@objc protocol InlineViewControllerDelegate {
    @objc optional func inlineViewControllerRequireAutolayout(_ viewController:InlineViewController)
    @objc optional func inlineViewControllerRequireShowOutline(_ viewController:InlineViewController)
}

class InlineViewController: BaseViewController {
    var delegate: InlineViewControllerDelegate?
    var ready: Bool = false
    
    override func resetData() {
        super.resetData()
        ready = false;
    }
    
    override func updateData() {
        ready = true;
        if let inlineViewControllerRequireAutolayout = delegate?.inlineViewControllerRequireAutolayout {
            inlineViewControllerRequireAutolayout(self)
        }
    }
    
    override func handleNetworkError(error: NSError) {
        _error = error
    }
    
    func heightOfViewWithWidth(_ width:CGFloat) -> CGFloat{
        return _error != nil ? -1 : 0
    }
}
