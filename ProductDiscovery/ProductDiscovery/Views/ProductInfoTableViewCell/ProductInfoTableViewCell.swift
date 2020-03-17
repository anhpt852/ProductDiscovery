//
//  ProductInfoTableViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/17/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var _lbProductInfoTitle: UILabel!
    @IBOutlet weak var _lbProductInfoValue: UILabel!
    @IBOutlet weak var _vBackground: UIView!
    
    var info: ProductAttributes? {
        didSet {
            if let name =  info!.name ,let value =  info!.value{
                _lbProductInfoTitle.text = name
                _lbProductInfoValue.text = value
            }
        }
    }
    
    var cellBackgroundColor: UIColor? {
        didSet {
            if let _backgroundColor =  cellBackgroundColor {
                self._vBackground.backgroundColor = _backgroundColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public static func cell_identifier() -> String{
        return "product_info_view_cell";
    }
}
