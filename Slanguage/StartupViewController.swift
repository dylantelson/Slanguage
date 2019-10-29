//
//  StartupViewController.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/29/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class StartupViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            let languageSelect = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! UITabBarController
            self.present(languageSelect, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton!) {
        if(sender.tag == 0) {
            self.performSegue(withIdentifier: "startToLogin", sender: self)
        } else {
            self.performSegue(withIdentifier: "startToSignup", sender: self)
        }
    }
}
