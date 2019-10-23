//
//  ChooseLanguage.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/22/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit

class ChooseLanguage: UIViewController {
    
    @IBAction func checkButtonClicked(sender: UIButton!) {
        let learnScreen = self.storyboard?.instantiateViewController(withIdentifier: "Translate") as! Translate
        learnScreen.currLanguage = sender.tag
        self.present(learnScreen, animated: true, completion: nil)
    }
}
