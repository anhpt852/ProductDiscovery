//
//  ProductDetailBottomContainerViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductDetailBottomContainerViewController: InlineViewController {

    @IBOutlet weak var _lbTitle: UILabel!
    @IBOutlet weak var _vCollection: UICollectionView!
    
    var _product: ProductItemEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
        // Do any additional setup after loading the view.
    }
    
    override func refreshData() {
        super.refreshData();
    }


}

extension ProductDetailBottomContainerViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell.init()
    }
    
    
}
