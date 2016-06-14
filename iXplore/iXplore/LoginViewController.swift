//
//  LoginViewController.swift
//  iXplore
//
//  Created by Serene Mirza on 6/14/16.
//  Copyright © 2016 Natalie Polk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        appDelegate.navigateToLandingView()
    }


    
}
