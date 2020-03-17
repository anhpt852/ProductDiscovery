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
    var listProducts = [ProductItemEntity]()
    
    var _product: ProductItemEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        
        _vCollection.register(UINib(nibName: "ProductListHorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProductListHorizontalCollectionViewCell.cell_identifier())
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func fetchData() {
        NetworkManager.sharedManager.getListProduct(1,"",{result in
            do {
                let value = try result.get()
                if let result = value.result{
                    if let products =  result.products{
                        self.listProducts = products;
                        self._vCollection.reloadData();
                        self.updateData()
                    }
                }
            }
            catch{
                
            }
        })
    }
    override func refreshData() {
        super.refreshData();
    }

}

extension ProductDetailBottomContainerViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = listProducts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListHorizontalCollectionViewCell.cell_identifier(), for: indexPath) as! ProductListHorizontalCollectionViewCell
        cell.product = item

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 166, height: 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
