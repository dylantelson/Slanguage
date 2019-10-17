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
            wordsToClick.last!.titleLabel!.text = wordsToTranslate[n]
            wordsToClick.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.titleLabel!.intrinsicContentSize.width + 10, height: wordsToClick.last!.titleLabel!.intrinsicContentSize.height + 4)
            wordsToClick.last!.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
            wordsToClick.last!.layer.cornerRadius = wordsToClick.last!.frame.height/2
            wordsToClick.last!.setTitleColor(UIColor.white, for: .normal)
            wordsToClick.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClick.last!.layer.shadowRadius = 4
            wordsToClick.last!.layer.shadowOpacity = 0.5
            wordsToClick.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClick.last!.titleLabel!.textAlignment = .center
            self.view.addSubview(wordsToClick.last!)
        }
    }
    
}

