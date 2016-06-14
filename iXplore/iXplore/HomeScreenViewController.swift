//
//  HomeScreenViewController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/14/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonTapped(sender: AnyObject) {
        let lvc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }
    
    @IBAction func registerButtonTapped(sender: AnyObject) {
        let rvc = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(rvc, animated: true)
    }

}
