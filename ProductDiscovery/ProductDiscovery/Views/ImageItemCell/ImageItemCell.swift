//
//  ImageItemCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ImageItemCell: UIView {
    @IBOutlet weak var _ivProductImage: UIImageView!
    
    var _imageURL: URL? {
        didSet {
            if let imageURL = _imageURL {
                _ivProductImage.sd_setImage(with: imageURL, completed: nil)
            }
        }
    }
    
//    override init (frame : CGRect) {
//        super.init(frame : frame)
//    }
//
//    convenience init(_ imageURL:URL) {
//        self.init(frame: CGRect.zero)
//        if let imageURL = _imageURL {
//            _ivProductImage.sd_setImage(with: imageURL, completed: nil)
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
}
