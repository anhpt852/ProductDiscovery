//
//  ViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/16/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController{
    

    @IBOutlet weak var _tableView: UITableView!
    var listProducts = [ProductListEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _tableView.register(UINib(nibName: "ProductListViewTableViewCell", bundle: nil), forCellReuseIdentifier: ProductListViewTableViewCell.cell_identifier())
        self.fetchData()
    }
    
    override func fetchData() {
        NetworkManager.sharedManager.getListProduct({result in
            do {
                let value = try result.get()
                
                let product = value.result?.products![0];
                let status = product?.status?.sale;
                NSLog("\(value)")
                NSLog("\(status!)")
            }
            catch{
                
            }
            
        })
    }

}

extension ProductListViewController: UITableViewDelegate,UITableViewDataSource {

    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProducts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListViewTableViewCell.cell_identifier())!
        return cell
    }
}

