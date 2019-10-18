//
//  ViewController.swift
//  asd
//
//  Created by Dylan Telson on 10/17/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import UIKit

var slangsArgOrig = ["Estoy al horno", "Tengo mala leche", "Sos un boludo"]
var slangsArgTranslated = ["I'm screwed", "I have bad luck", "you're a jerk"]

var userTranslation = [String]()

var wordsToTranslate = [String]()
var wordsToClick = [UIButton]()

var currLanguage = "Arg"
var currString = 0

class Translate: UIViewController {
    
@IBOutlet var textToTranslate : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPhrase()
        // Do any additional setup after loading the view.
    }
    
    func newPhrase() {
        currString = Int.random(in: 0 ..< slangsArgOrig.count)
        textToTranslate.text = slangsArgOrig[currString]
        for button in wordsToClick {
            button.removeFromSuperview()
        }
        userTranslation.removeAll()
        wordsToTranslate.removeAll()
        wordsToClick.removeAll()
        wordsToTranslate = slangsArgTranslated[currString].components(separatedBy: " ")
        wordsToTranslate.shuffle()
        for n in 0 ..< wordsToTranslate.count {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 100, y: 500, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 500, width: 0, height: 0)))
            }
            wordsToClick.last!.setTitle(wordsToTranslate[n], for: .normal)
            wordsToClick.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.titleLabel!.intrinsicContentSize.width + 10, height: wordsToClick.last!.titleLabel!.intrinsicContentSize.height + 4)
            wordsToClick.last!.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
            wordsToClick.last!.layer.cornerRadius = wordsToClick.last!.frame.height/2
            wordsToClick.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClick.last!.layer.shadowRadius = 4
            wordsToClick.last!.layer.shadowOpacity = 0.5
            wordsToClick.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClick.last!.titleLabel!.textAlignment = .center
            wordsToClick.last!.tag = n
            wordsToClick.last!.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            //wordsToClick.last!.titleLabel!.font = UIFont(name: "Helvetica", size: 19.0)
            wordsToClick.last!.setTitleColor(UIColor.white, for: .normal)
            self.view.addSubview(wordsToClick.last!)
        }
    }
    
    @objc func buttonClicked(sender: UIButton!) {
        print("Pressed!")
        if(sender.frame.origin.y == 500) {
            sender.frame.origin.y = 300
            userTranslation.append(sender.titleLabel!.text!)
        } else if(sender.frame.origin.y == 300) {
            sender.frame.origin.y = 500
            userTranslation.remove(at: userTranslation.firstIndex(of: sender.titleLabel!.text!)!)
        }
    }
    
    @IBAction func checkButtonClicked(sender: UIButton!) {
        let finalTranslation = userTranslation.joined(separator: " ")
        if(finalTranslation == slangsArgTranslated[currString]) {
            print("Correct!")
            newPhrase()
        } else {
            print("Given: " + finalTranslation)
            print("Expected: " + slangsArgTranslated[currString])
            print("Incorrect, please try again!")
        }
    }
    
}

