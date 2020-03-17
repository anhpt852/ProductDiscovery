//
//  Int+Convert.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/18/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import Foundation

extension Double {
    func formatMoneyNumber() -> NSMutableAttributedString {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        let fontSuper:UIFont? = UIFont.systemFont(ofSize: 10)
        let attString:NSMutableAttributedString = NSMutableAttributedString(string: formater.string(from: NSNumber(value: self))! + " đ", attributes: [:])
        attString.setAttributes([NSAttributedString.Key.font:fontSuper!,NSAttributedString.Key.baselineOffset:6], range: NSRange(location:attString.length - 1,length:1))
        return attString
    }
}
