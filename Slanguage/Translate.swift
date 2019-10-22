//
//  ViewController.swift
//  asd
//
//  Created by Dylan Telson on 10/17/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import UIKit
import AVFoundation

var randomEnglishWords = ["very", "super", "tired", "terrible", "jerk", "screwed", "but", "cheese", "have", "a", "an", "really"]
var randomSpanishWords = ["pero", "no", "la", "verdad", "terrible", "soy", "leche", "boludo", "pilas", "fiaca", "el", "ella", "muy"]

var slangsArgOrig = ["Estoy al horno", "Tengo mala leche", "Sos un boludo", "Che, tengo mucha fiaca", "Estoy re al pedo", "Dale, ponete las pilas", "Estoy en pedo", "Ni a palos"]
var slangsArgTranslated = ["I'm screwed", "I have bad luck", "You're a jerk", "Dude, I'm really lazy", "I'm not doing anything", "C'mon, get yourself together", "I am drunk", "Not even close"]

var readyForNext = true

var userTranslation = [String]()

var wordsToTranslate = [String]()
var wordsToClick = [UIButton]()

var buttonsAtBottom = [UIButton]()
var buttonsAtTop = [UIButton]()

var audioClipsArg = ["estoyalhorno", "tengomalaleche", "sosunboludo", "chetengomuchafiaca", "estoyrealpedo", "daleponetelaspilas", "estoyenpedo", "niapalos"]

var currLanguage = "Arg"
var currString = 0

//0 means Orig to Translated (orig), 1 means Translated to Orig
var promptType = 0

class Translate: UIViewController {
    
    @IBOutlet var textToTranslate : UILabel!
    @IBOutlet var checkButton : UIButton!
    @IBOutlet var hearButton : UIButton!
    @IBOutlet var correctPopup : UIView!
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(correctPopup)
        checkButton.backgroundColor = UIColor(red: 0.419, green: 0.73, blue: 0.925, alpha: 1)
        checkButton.layer.cornerRadius = checkButton.frame.height/2
        checkButton.layer.shadowColor = UIColor.darkGray.cgColor
        checkButton.layer.shadowRadius = 4
        checkButton.layer.shadowOpacity = 0.5
        checkButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        checkButton.titleLabel!.textAlignment = .center
        checkButton.setTitleColor(UIColor.white, for: .normal)
        newPrompt()
        // Do any additional setup after loading the view.
    }
    
    func newPrompt() {
        correctPopup.frame.origin.y = 900
        readyForNext = false
        checkButton.setTitle("Check", for: .normal)
        let promptToChooseNum = Int.random(in: 0 ... 1)
        if(promptToChooseNum == 0) {
            newPhrase()
            promptType = 0
        } else {
            newPhraseReversed()
            promptType = 1
        }
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
        buttonsAtTop.removeAll()
        buttonsAtBottom.removeAll()
        wordsToTranslate = slangsArgTranslated[currString].components(separatedBy: " ")
        while(wordsToTranslate.count < 8) {
            let randomWord = randomEnglishWords[Int.random(in: 0 ... randomEnglishWords.count - 1)]
            if(wordsToTranslate.contains(randomWord)) {
                continue
            }
            wordsToTranslate.append(randomWord)
        }
        wordsToTranslate.shuffle()
        for n in 0 ..< wordsToTranslate.count {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 100, y: 500, width: 0, height: 0)))
            } else if(n<4) {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 500, width: 0, height: 0)))
            } else if(n==4){
                wordsToClick.append(UIButton(frame: CGRect(x: 100, y: 600, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
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
//            for word in wordsToClick {
//                buttonsAtBottom.append(word)
//            }
            buttonsAtBottom = wordsToClick
            self.view.addSubview(wordsToClick.last!)
        }
        print("curr: " + String(currString))
        textToTranslate.sizeToFit()
        textToTranslate.center = view.center
        textToTranslate.frame.origin.y = 220
        //hearButton.frame.origin.x = textToTranslate.frame.origin.x - 60
        hearButton.isEnabled = true
        playAudio()
    }
    
    func newPhraseReversed() {
        currString = Int.random(in: 0 ..< slangsArgTranslated.count)
        textToTranslate.text = slangsArgTranslated[currString]
        for button in wordsToClick {
            button.removeFromSuperview()
        }
        userTranslation.removeAll()
        wordsToTranslate.removeAll()
        wordsToClick.removeAll()
        buttonsAtTop.removeAll()
        buttonsAtBottom.removeAll()
        wordsToTranslate = slangsArgOrig[currString].components(separatedBy: " ")
        while(wordsToTranslate.count < 8) {
            let randomWord = randomSpanishWords[Int.random(in: 0 ... randomSpanishWords.count - 1)]
            if(wordsToTranslate.contains(randomWord)) {
                continue
            }
            wordsToTranslate.append(randomWord)
        }
        wordsToTranslate.shuffle()
        for n in 0 ..< wordsToTranslate.count {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 100, y: 500, width: 0, height: 0)))
            } else if(n<4) {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 500, width: 0, height: 0)))
            } else if(n==4){
                wordsToClick.append(UIButton(frame: CGRect(x: 100, y: 600, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
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
            //            for word in wordsToClick {
            //                buttonsAtBottom.append(word)
            //            }
            buttonsAtBottom = wordsToClick
            self.view.addSubview(wordsToClick.last!)
        }
        textToTranslate.sizeToFit()
        textToTranslate.center = view.center
        textToTranslate.frame.origin.y = 220
        hearButton.isEnabled = false
        //hearButton.frame.origin.x = textToTranslate.frame.origin.x - 60
    }
    
    @objc func buttonClicked(sender: UIButton!) {
        if(sender.frame.origin.y >= 500) {
            let ind = buttonsAtBottom.firstIndex(of: sender)!
            if(ind < buttonsAtBottom.count - 1) {
                //buttonsAtBottom[ind+1].frame.origin.x = buttonsAtBottom[ind].frame.origin.x + buttonsAtBottom[ind].frame.width + 15
                UIView.animate(withDuration: 0.2, animations: {
                    buttonsAtBottom[ind+1].frame = CGRect(x: buttonsAtBottom[ind].frame.origin.x + buttonsAtBottom[ind].frame.width + 15, y: buttonsAtBottom[ind+1].frame.origin.y, width: buttonsAtBottom[ind+1].frame.width, height: buttonsAtBottom[ind+1].frame.height)
                })
                buttonsAtBottom.remove(at: ind)
            } else {
                buttonsAtBottom.remove(at: ind)
            }
            for n in buttonsAtBottom.distance(from: buttonsAtBottom.startIndex, to: ind) ..< buttonsAtBottom.count {
                if(n == 3) {
                    var dest = CGPoint(x: 0, y: 0)
//                    buttonsAtBottom[3].frame.origin.x = buttonsAtBottom[2].frame.origin.x + buttonsAtBottom[2].frame.width + 15
//                    buttonsAtBottom[3].frame.origin.y = 500
                    dest.x = buttonsAtBottom[2].frame.origin.x + buttonsAtBottom[2].frame.width + 15
                    dest.y = 500
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[3].frame = CGRect(x: dest.x, y: dest.y, width: buttonsAtBottom[3].frame.size.width, height: buttonsAtBottom[3].frame.size.height)
                    })
                }
                if(n == 4) {
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[4].frame = CGRect(x: 100, y: buttonsAtBottom[4].frame.origin.y, width: buttonsAtBottom[4].frame.size.width, height: buttonsAtBottom[4].frame.size.height)
                    })
                } else if(n == 5) {
                    //buttonsAtBottom[4].frame.origin.x = 100
                    //buttonsAtBottom[5].frame.origin.x = buttonsAtBottom[4].frame.origin.x + buttonsAtBottom[4].frame.width + 15
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[5].frame = CGRect(x: buttonsAtBottom[4].frame.origin.x + buttonsAtBottom[4].frame.width + 15, y: buttonsAtBottom[5].frame.origin.y, width: buttonsAtBottom[5].frame.size.width, height: buttonsAtBottom[5].frame.size.height)
                    })
                    
                    if(buttonsAtBottom.count > 6) {
//                        buttonsAtBottom[6].frame.origin.x = buttonsAtBottom[5].frame.origin.x + buttonsAtBottom[5].frame.width + 15
                        UIView.animate(withDuration: 0.2, animations: {
                            buttonsAtBottom[6].frame = CGRect(x: buttonsAtBottom[5].frame.origin.x + buttonsAtBottom[5].frame.width + 15, y: buttonsAtBottom[6].frame.origin.y, width: buttonsAtBottom[6].frame.size.width, height: buttonsAtBottom[6].frame.size.height)
                        })
                        continue
                    }
                }
                else if(n > 0) {
                    //buttonsAtBottom[n].frame.origin.x = buttonsAtBottom[n-1].frame.origin.x + buttonsAtBottom[n-1].frame.width + 15
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[n].frame = CGRect(x: buttonsAtBottom[n-1].frame.origin.x + buttonsAtBottom[n-1].frame.width + 15, y: buttonsAtBottom[n].frame.origin.y, width: buttonsAtBottom[n].frame.size.width, height: buttonsAtBottom[n].frame.size.height)
                    })
                } else {
                    //buttonsAtBottom[n].frame.origin.x = 100
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[n].frame = CGRect(x: 100, y: buttonsAtBottom[n].frame.origin.y, width: buttonsAtBottom[n].frame.size.width, height: buttonsAtBottom[n].frame.size.height)
                    })
                }
            }
            //buttonsAtBottom.remove(at: buttonsAtBottom.firstIndex(of: sender)!)
            var dest = CGPoint(x: 0, y: 0)
            if(userTranslation.count == 0 || buttonsAtTop.count == 4) {
                //sender.frame.origin.x = 100
                dest.x = 100
            } else {
                //sender.frame.origin.x = buttonsAtTop.last!.frame.origin.x + buttonsAtTop.last!.frame.width + 15
                dest.x = buttonsAtTop.last!.frame.origin.x + buttonsAtTop.last!.frame.width + 15
            }
            if(buttonsAtTop.count < 4) {
                //sender.frame.origin.y = 300
                dest.y = 300
            } else {
                //sender.frame.origin.y = 400
                dest.y = 400
            }
            UIView.animate(withDuration: 0.2, animations: {
                sender.frame = CGRect(x: dest.x, y: dest.y, width: sender.frame.size.width, height: sender.frame.size.height)
            })
            buttonsAtTop.append(sender)
            userTranslation.append(sender.titleLabel!.text!)
        } else if(sender.frame.origin.y <= 400) {
            let ind = buttonsAtTop.firstIndex(of: sender)!
            if(ind < buttonsAtTop.count - 1) {
                //buttonsAtTop[ind+1].frame.origin.x = buttonsAtTop[ind].frame.origin.x + buttonsAtTop[ind].frame.width + 15
                UIView.animate(withDuration: 0.2, animations: {
                    buttonsAtTop[ind+1].frame = CGRect(x: buttonsAtTop[ind].frame.origin.x + buttonsAtTop[ind].frame.width + 15, y: buttonsAtTop[ind+1].frame.origin.y, width: buttonsAtTop[ind+1].frame.width, height: buttonsAtTop[ind+1].frame.height)
                })
                buttonsAtTop.remove(at: ind)
            } else {
                buttonsAtTop.remove(at: ind)
            }
            for n in buttonsAtTop.distance(from: buttonsAtTop.startIndex, to: ind) ..< buttonsAtTop.count {
                if(n == 3) {
//                    buttonsAtTop[3].frame.origin.x = buttonsAtTop[2].frame.origin.x + buttonsAtTop[2].frame.width + 15
//                    buttonsAtTop[3].frame.origin.y = 300
                    var dest = CGPoint(x: 0, y: 0)
                    dest.x = buttonsAtTop[2].frame.origin.x + buttonsAtTop[2].frame.width + 15
                    dest.y = 300
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtTop[3].frame = CGRect(x: dest.x, y: dest.y, width: buttonsAtTop[3].frame.size.width, height: buttonsAtTop[3].frame.size.height)
                    })
                }
                if(n == 4) {
                    //buttonsAtTop[4].frame.origin.x = 100
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtTop[4].frame = CGRect(x: 100, y: buttonsAtTop[4].frame.origin.y, width: buttonsAtTop[4].frame.size.width, height: buttonsAtTop[4].frame.size.height)
                    })
                } else if(n == 5) {
                    //buttonsAtBottom[4].frame.origin.x = 100
                    //buttonsAtTop[5].frame.origin.x = buttonsAtTop[4].frame.origin.x + buttonsAtTop[4].frame.width + 15
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtTop[5].frame = CGRect(x: buttonsAtTop[4].frame.origin.x + buttonsAtTop[4].frame.width + 15, y: buttonsAtTop[5].frame.origin.y, width: buttonsAtTop[5].frame.size.width, height: buttonsAtTop[5].frame.size.height)
                    })
                    if(buttonsAtTop.count > 6) {
                        //buttonsAtTop[6].frame.origin.x = buttonsAtTop[5].frame.origin.x + buttonsAtTop[5].frame.width + 15
                        UIView.animate(withDuration: 0.2, animations: {
                            buttonsAtTop[6].frame = CGRect(x: buttonsAtTop[5].frame.origin.x + buttonsAtTop[5].frame.width + 15, y: buttonsAtTop[6].frame.origin.y, width: buttonsAtTop[6].frame.size.width, height: buttonsAtTop[6].frame.size.height)
                        })
                        continue
                    }
                }
                else if(n > 0) {
                    //buttonsAtTop[n].frame.origin.x = buttonsAtTop[n-1].frame.origin.x + buttonsAtTop[n-1].frame.width + 15
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtTop[n].frame = CGRect(x: buttonsAtTop[n-1].frame.origin.x + buttonsAtTop[n-1].frame.width + 15, y: buttonsAtTop[n].frame.origin.y, width: buttonsAtTop[n].frame.size.width, height: buttonsAtTop[n].frame.size.height)
                    })
                } else {
                    //buttonsAtTop[n].frame.origin.x = 100
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtTop[n].frame = CGRect(x: 100, y: buttonsAtTop[n].frame.origin.y, width: buttonsAtTop[n].frame.size.width, height: buttonsAtTop[n].frame.size.height)
                    })
                }
            }
            //buttonsAtTop.remove(at: buttonsAtTop.firstIndex(of: sender)!)
            var dest = CGPoint(x: 0, y: 0)
            if(buttonsAtBottom.count == 0 || buttonsAtBottom.count == 4) {
                //sender.frame.origin.x = 100
                dest.x = 100
            } else {
                //sender.frame.origin.x = buttonsAtBottom.last!.frame.origin.x + buttonsAtBottom.last!.frame.width + 15
                dest.x = buttonsAtBottom.last!.frame.origin.x + buttonsAtBottom.last!.frame.width + 15
            }
            if(buttonsAtBottom.count < 4) {
                //sender.frame.origin.y = 500
                dest.y = 500
            } else {
                //sender.frame.origin.y = 600
                dest.y = 600
            }
            UIView.animate(withDuration: 0.2, animations: {
                sender.frame = CGRect(x: dest.x, y: dest.y, width: sender.frame.size.width, height: sender.frame.size.height)
            })
            buttonsAtBottom.append(sender)
//            var rightMostIndex = 0
//            var rightMostXValue = 0
//            for n in 0 ..< wordsToClick.count {
//                if(wordsToClick[n].frame.origin.y == 500 && rightMostXValue < Int(wordsToClick[n].frame.origin.x)) {
//                    rightMostXValue = Int(wordsToClick[n].frame.origin.x)
//                    rightMostIndex = n
//                }
//            }
//            if(rightMostXValue == 9999) {
//                sender.frame.origin.x = 100
//            } else {
//                sender.frame.origin.x = wordsToClick[rightMostIndex].frame.origin.x + wordsToClick[rightMostIndex].frame.width + 15
//            }
            userTranslation.remove(at: userTranslation.firstIndex(of: sender.titleLabel!.text!)!)
        }
    }
    
    @IBAction func checkButtonClicked(sender: UIButton!) {
        if(readyForNext == false) {
            let finalTranslation = userTranslation.joined(separator: " ")
            if(promptType == 0) {
                if(finalTranslation == slangsArgTranslated[currString]) {
                    print("Correct!")
                    readyForNext = true
                    checkButton.setTitle("Next", for: .normal)
                    UIView.animate(withDuration: 0.2, animations: {
                        self.correctPopup.frame.origin.y = 730
                    })
                } else {
                    print("Given: " + finalTranslation)
                    print("Expected: " + slangsArgTranslated[currString])
                    print("Incorrect, please try again!")
                }
            } else if(promptType == 1) {
                if(finalTranslation == slangsArgOrig[currString]) {
                    print("Correct!")
                    hearButton.isEnabled = true
                    playAudio()
                    readyForNext = true
                    checkButton.setTitle("Next", for: .normal)
                    UIView.animate(withDuration: 0.2, animations: {
                        self.correctPopup.frame.origin.y = 730
                    })
                } else {
                    print("Given: " + finalTranslation)
                    print("Expected: " + slangsArgOrig[currString])
                    print("Incorrect, please try again!")
                }
            }
        } else {
            newPrompt()
        }
    }
    
    @IBAction func hearButtonClicked(sender: UIButton!) {
        playAudio()
    }
    
    //learned how to play audio from: https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
    func playAudio() {
        print(currString)
        guard let url = Bundle.main.url(forResource: audioClipsArg[currString], withExtension: "mp3") else {
            print("Cannot find audio file")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            player.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
    
}

