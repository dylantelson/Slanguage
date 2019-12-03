//
//  SignUpViewController.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/29/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var email : UITextField!
    @IBOutlet weak var pass : UITextField!
    @IBOutlet weak var confirmpass : UITextField!
    @IBOutlet weak var username : UITextField!
    
    @IBAction func signUpClicked(_ sender: Any) {
        if(pass.text != confirmpass.text) {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else if(username.text!.count < 4) {
            let alertController = UIAlertController(title: "Error", message: "Username must be at least 4 characters long.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: pass.text!){ (user, error) in
                if error == nil {
                    print("len: ", self.username.text!.count)
                    let db = Firestore.firestore()
                    db.collection("users").document((user?.user.uid)!).setData(["score": 0, "username":self.username.text!, "currlang":"null"])
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
