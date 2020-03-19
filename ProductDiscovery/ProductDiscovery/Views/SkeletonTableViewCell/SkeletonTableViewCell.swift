//
//  SkeletonTableViewCell.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/19/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class SkeletonTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sublabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
