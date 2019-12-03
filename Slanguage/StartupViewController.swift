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

class StartupViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        let db = Firestore.firestore()
        if Auth.auth().currentUser != nil {
//            let languageSelect = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! UITabBarController
//            self.present(languageSelect, animated: true, completion: nil)
            
            let currUserData = db.collection("users").document(Auth.auth().currentUser!.uid)

            currUserData.getDocument { (document, error) in
                if let document = document, document.exists {
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    UserDefaults.standard.set(document["score"], forKey: "UserScore")
                    UserDefaults.standard.set(document["username"], forKey: "Username")
                    UserDefaults.standard.set(document["currLang"], forKey: "currLang")
                    self.performSegue(withIdentifier: "startToHome", sender: self)
                } else {
                    print("Document does not exist")
                }
            }
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
