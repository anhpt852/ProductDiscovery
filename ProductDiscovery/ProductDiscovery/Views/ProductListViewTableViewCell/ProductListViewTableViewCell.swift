//
//  ProductListViewTableViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductListViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var _ivProductThumb: UIImageView!
    @IBOutlet weak var _lbProductName: UILabel!
    @IBOutlet weak var _lbProductPrice: UILabel!
    @IBOutlet weak var _lbProductOldPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public static func cell_identifier() -> String{
        return "list_product_view_cell";
    }
    
}
