//
//  HomeVC.swift
//  AuthoApp
//
//  Created by admin on 24.12.2020.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var logOutBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutBTN.layer.cornerRadius = 8
    }
    
    @IBAction func logOutAct(_ sender: Any) {
        mainViewSegue()
    }
}

