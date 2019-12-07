//
//  LoginViewController.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/29/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var pass : UITextField!
    
    //Learned how to use Firebase from the following article: https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-within-15-mins-df4731faf2f7
    @IBAction func loginClicked(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (user, error) in
            if error == nil {
                let currUserData = Firestore.firestore().collection("users").document(Auth.auth().currentUser!.uid)
                currUserData.getDocument { (document, error) in
                    if let document = document, document.exists {
                        //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        UserDefaults.standard.set(document["score"], forKey: "UserScore")
                        UserDefaults.standard.set(document["username"], forKey: "UserName")
                        UserDefaults.standard.set(document["currLang"], forKey: "currLang")
                        self.performSegue(withIdentifier: "loginToHome", sender: self)
                    } else {
                        let alertController = UIAlertController(title: "No user found", message: "Could not find any info with that email.", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
}
