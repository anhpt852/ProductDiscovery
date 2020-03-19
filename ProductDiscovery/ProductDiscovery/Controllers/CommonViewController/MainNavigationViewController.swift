//
//  MainNavigationControllerViewController.swift
//  ProductDiscovery
//
//  Created by Phan Tuan Anh on 3/19/20.
//  Copyright © 2020 anhpt. All rights reserved.
//

import UIKit
import Alamofire
import PMAlertController

class MainNavigationViewController: UINavigationController {
    static let shared = MainNavigationViewController()
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    let alert:PMAlertController = PMAlertController(title: "Notice", description: "Internet connection is disabled", image: nil, style: .alert)
//    var _errorVC = StoryboardManager.mainManager.instantiateViewControllerWithIdentifier(identifier: "error_internet_view_controller") as? ErrorInternetViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startNetworkReachabilityObserver()
        alert.addAction(PMAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default, action: {() in
        }))
//        _errorVC!.modalPresentationStyle = .fullScreen
        // Do any additional setup after loading the view.
    }

    func startNetworkReachabilityObserver() {

        reachabilityManager?.startListening(onUpdatePerforming: { (status) in
            switch status {

            case .notReachable,.unknown :
               
                self.present(self.alert, animated: true, completion: nil)

            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
//                self._errorVC?.dismiss(animated: true, completion: nil)
                self.alert.dismiss(animated: true, completion: nil)
            }
        })
    }
}

