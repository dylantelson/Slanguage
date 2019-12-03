/* MAIN TODOLIST:
 1) Add more phrases and slang
 2) Add more types of minigames- look at other language learning apps and see what they do
 3) Add more languages
 4) Add audio for when you get the right answer, wrong answer, etc. Normal sound effects
 5) Add icons for the tab view
*/

import UIKit
import AVFoundation
import Firebase

let languages = ["arg", "aus", "bra"]

let flagNames = ["argentinasmall", "australiasmall", "brazilsmall", "italysmall"]

let randomUsaWords = ["very", "super", "tired", "terrible", "jerk", "screwed", "but", "cheese", "have", "a", "an", "really"]
let randomArgWords = ["pero", "no", "la", "verdad", "terrible", "soy", "leche", "boludo", "pilas", "fiaca", "el", "ella", "muy"]
let randomAusWords = ["very", "super", "tired", "terrible", "maccas", "screwed", "but", "cheese", "barbie", "a", "an", "really", "avo", "dog", "ankle", "biter"]
let randomBraWords = ["legal", "muito", "ela", "ruim", "louco", "coraçao", "desafinado", "queijo", "bacana", "bom", "beleza", "cara", "gato", "valeu", "bola", "verdade"]

let randomOrigWordArray = [randomArgWords, randomAusWords, randomBraWords]

let slangsArgOrigPhrases = ["Estoy al horno", "Tengo mala leche", "Sos un boludo", "Che, tengo mucha fiaca", "Estoy re al pedo", "Dale, ponete las pilas", "Estoy en pedo", "Ni a palos"]
let slangsArgTranslatedPhrases = ["I'm screwed", "I have bad luck", "You're a jerk", "Dude, I'm really lazy", "I'm not doing anything", "C'mon, get yourself together", "I am drunk", "Not even close"]

var slangsAusOrigPhrases = ["My son's room is a dog's breakfast", "Put the maccas on the barbie", "My ankle biter wants an avo"]
var slangsAusTranslatedPhrases = ["My son's room is a mess", "Put the McDonalds on the barbecue", "My child wants an avocado"]

var slangsBraOrigPhrases = ["Cala boca, deveria se aposentar", "Voçe é meu Deus", "Voçe pisou na bola feio comigo", "Ops, foi mal"]
var slangsBraTranslatedPhrases = ["Shut up, you should retire", "You are my God", "You really let me down", "Whoops, my bad"]

var audioClipsArgPhrases = ["estoyalhorno", "tengomalaleche", "sosunboludo", "chetengomuchafiaca", "estoyrealpedo", "daleponetelaspilas", "estoyenpedo", "niapalos"]
var audioClipsAusPhrases = ["estoyalhorno", "tengomalaleche", "sosunboludo"]
var audioClipsBraPhrases = ["estoyalhorno", "tengomalaleche", "sosunboludo", "estoyrealpedo"]

var currSlangOrigPhrases = [String]()
var currSlangTranslatedPhrases = [String]()
var currAudioClipsPhrases = [String]()

var slangsArgOrigWords = ["al horno", "mala leche", "boludo", "fiaca", "che", "pibe", "mina", "laburo", "pelotudo", "quilombo", "groso", "dale"]
var slangsArgTranslatedWords = ["screwed", "bad luck", "jerk", "laziness", "dude", "guy", "girl", "work", "dumbass", "mess", "awesome", "c'mon"]

var slangsAusOrigWords = ["bogan", "brolly", "ankle biter", "chook", "crikey", "dag", "dunny", "durry", "frothy", "sheila", "straya", "bruce"]
var slangsAusTranslatedWords = ["redneck", "umbrella", "child", "chicken", "wow", "nerd", "toilet", "cigarette", "beer", "woman", "australia", "man"]

var slangsBraOrigWords = ["legal", "cara", "bacana", "beleza", "valeu", "aposentar", "joia", "cabeça-dura", "foi mal", "e aí", "demorou", "treta"]
var slangsBraTranslatedWords = ["awesome", "dude", "nice", "beauty", "thanks", "retire", "great", "stubborn", "my bad", "what's up", "of course", "fight"]

//replace these with the words after recording them- for now just Spanish placeholders from the phrases
var audioClipsArgWords = ["estoyalhorno", "tengomalaleche", "sosunboludo", "chetengomuchafiaca", "estoyrealpedo", "daleponetelaspilas", "estoyenpedo", "niapalos", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno"]
var audioClipsAusWords = ["estoyalhorno", "tengomalaleche", "sosunboludo", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno"]
var audioClipsBraWords = ["estoyalhorno", "tengomalaleche", "sosunboludo", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno", "estoyalhorno"]

var currSlangOrigWords = [String]()
var currSlangTranslatedWords = [String]()
var currAudioClipsWords = [String]()

var languagesOrigPhrases = [slangsArgOrigPhrases, slangsAusOrigPhrases, slangsBraOrigPhrases]
var languagesTranslatedPhrases = [slangsArgTranslatedPhrases, slangsAusTranslatedPhrases, slangsBraTranslatedPhrases]
var languageAudioClipsPhrases = [audioClipsArgPhrases, audioClipsAusPhrases, audioClipsBraPhrases]

var languagesOrigWords = [slangsArgOrigWords, slangsAusOrigWords, slangsBraOrigWords]
var languagesTranslatedWords = [slangsArgTranslatedWords, slangsAusTranslatedWords, slangsBraTranslatedWords]
var languageAudioClipsWords = [audioClipsArgWords, audioClipsAusWords, audioClipsBraWords]

var readyForNext = true

var userTranslation = [String]()

var wordsToTranslate = [String]()
var wordsToClick = [UIButton]()

var wordsToClickFrame = [UIButton]()

var buttonsAtBottom = [UIButton]()
var buttonsAtTop = [UIButton]()

var currString = 0

var initialAmountToLearn = 0

var currWordSelected : UIButton!
var currWordSelectedOrig = true

var numCorrectTapPairs = 0
var indexesOfWordsTapPairs = [String]()

//0 means Orig to Translated (orig), 1 means Translated to Orig
var promptType = 0

var lastCorrect = false

var score = 0

class Translate: UIViewController {
    var currLanguage = 0
    
    let db = Firestore.firestore()
    //currLanguage: 0 = Arg, 1 = Aus
//    init(currLang: Int) {
//        self.currLanguage = currLang
//        super.init(nibName: "Test", bundle: nil)
//    }
//
//    required init?(coder decoder: NSCoder) {
//        currLanguage = 0
//        super.init(coder: decoder)
//    }
    
    @IBOutlet var textToTranslate : UILabel!
    @IBOutlet var checkButton : UIButton!
    @IBOutlet var hearButton : UIButton!
    @IBOutlet var correctPopup : UIView!
    @IBOutlet var incorrectPopup : UIView!
    @IBOutlet var progressBar : UIProgressView!
    @IBOutlet var flag : UIImageView!
    @IBOutlet var lines1 : UIView!
    @IBOutlet var lines2 : UIView!
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currUserData = db.collection("users").document(Auth.auth().currentUser!.uid)
        currUserData.updateData([
            "currLang": languages[currLanguage]
        ]) { err in
            if let err = err {
                print("Error updating score: \(err)")
            } else {
                print("CurrLang successfully updated")
            }
        }
        
        
        view.sendSubviewToBack(correctPopup)
        view.sendSubviewToBack(incorrectPopup)
        checkButton.backgroundColor = UIColor(red: 0.39, green: 0.635, blue: 0.94, alpha: 1)
        checkButton.layer.cornerRadius = checkButton.frame.height/3
        checkButton.layer.shadowColor = UIColor.darkGray.cgColor
        checkButton.layer.shadowRadius = 1
        checkButton.layer.shadowOpacity = 0.5
        checkButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        checkButton.titleLabel!.textAlignment = .center
        checkButton.setTitleColor(UIColor.white, for: .normal)
        
        hearButton.backgroundColor = UIColor(red: 0.46667, green: 0.77647, blue: 0.98039, alpha: 1)
//        hearButton.layer.borderWidth = 1.0
//        hearButton.layer.borderColor = UIColor.lightGray.cgColor
        hearButton.layer.cornerRadius = hearButton.frame.height/3
        hearButton.layer.shadowColor = UIColor.blue.cgColor
        hearButton.layer.shadowRadius = 1
        hearButton.layer.shadowOpacity = 0.5
        hearButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        hearButton.titleLabel!.textAlignment = .center
        
        //learned to use CGAffineTransform from https://stackoverflow.com/questions/31259993/change-height-of-uiprogressview-in-swift/31260320
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 3)
        lines1.removeFromSuperview()
        lines2.removeFromSuperview()
        
        score = UserDefaults.standard.integer(forKey: "UserScore")
        startLearning()
        // Do any additional setup after loading the view.
    }
    
    func startLearning() {
        progressBar.setProgress(0, animated: false)
        currSlangOrigPhrases.removeAll()
        currSlangTranslatedPhrases.removeAll()
        currAudioClipsPhrases.removeAll()
        currSlangOrigWords.removeAll()
        currSlangTranslatedWords.removeAll()
        currAudioClipsWords.removeAll()
        for word  in languagesOrigPhrases[currLanguage] {
            currSlangOrigPhrases.append(word)
        }
        for word  in languagesTranslatedPhrases[currLanguage] {
            currSlangTranslatedPhrases.append(word)
        }
        for clip in languageAudioClipsPhrases[currLanguage] {
            currAudioClipsPhrases.append(clip)
        }
        for word in languagesOrigWords[currLanguage] {
            currSlangOrigWords.append(word)
        }
        for word  in languagesTranslatedWords[currLanguage] {
            currSlangTranslatedWords.append(word)
        }
        for clip in languageAudioClipsWords[currLanguage] {
            currAudioClipsWords.append(clip)
        }
        initialAmountToLearn = currSlangOrigPhrases.count + currSlangOrigWords.count / 4
        flag.image = UIImage(named: flagNames[currLanguage])
        newPrompt()
    }
    
    func newPrompt() {
        correctPopup.frame.origin.y = 900
        incorrectPopup.frame.origin.y = 900
        readyForNext = false
        lines1.removeFromSuperview()
        lines2.removeFromSuperview()
        hearButton.removeFromSuperview()
        checkButton.setTitle("Check", for: .normal)
        var promptToChooseNum = Int.random(in: 0 ... 2)
        if(promptToChooseNum == 0) {
            if(currSlangOrigPhrases.count > 0) {
                promptType = 0
                newPhrase()
                return
            } else {
                promptToChooseNum = 2
            }
        }
        if(promptToChooseNum == 1) {
            if(currSlangOrigPhrases.count > 0) {
                promptType = 1
                newPhraseReversed()
                return
            } else {
                promptToChooseNum = 2
            }
        }
        if(promptToChooseNum == 2) {
            if(currSlangOrigWords.count >= 4) {
                promptType = 2
                newWordPairer()
                return
            } else {
                newPrompt()
            }
        }
    }
    
    func newPhrase() {
        self.view.addSubview(lines1)
        self.view.addSubview(lines2)
        self.view.addSubview(hearButton)
        currString = Int.random(in: 0 ..< currSlangOrigPhrases.count)
        textToTranslate.text = currSlangOrigPhrases[currString]
        for button in wordsToClick {
            button.removeFromSuperview()
        }
        for button in wordsToClickFrame {
            button.removeFromSuperview()
        }
        userTranslation.removeAll()
        wordsToTranslate.removeAll()
        wordsToClick.removeAll()
        wordsToClickFrame.removeAll()
        buttonsAtTop.removeAll()
        buttonsAtBottom.removeAll()
        wordsToTranslate = currSlangTranslatedPhrases[currString].components(separatedBy: " ")
        while(wordsToTranslate.count < 8) {
            let randomWord = randomUsaWords[Int.random(in: 0 ... randomUsaWords.count - 1)]
            if(wordsToTranslate.contains(randomWord)) {
                continue
            }
            wordsToTranslate.append(randomWord)
        }
        wordsToTranslate.shuffle()
        for n in 0 ..< wordsToTranslate.count {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 550, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: 50, y: 550, width: 0, height: 0)))
            } else if(n<4) {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 550, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 550, width: 0, height: 0)))
            } else if(n==4){
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 600, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: 50, y: 600, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
            }
            wordsToClick.last!.setTitle(wordsToTranslate[n], for: .normal)
            wordsToClick.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.titleLabel!.intrinsicContentSize.width + 16, height: wordsToClick.last!.titleLabel!.intrinsicContentSize.height + 8)
//            wordsToClick.last!.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
            wordsToClick.last!.backgroundColor = UIColor.white
            wordsToClick.last!.layer.borderWidth = 1.0
            wordsToClick.last!.layer.borderColor = UIColor.lightGray.cgColor
            wordsToClick.last!.layer.cornerRadius = wordsToClick.last!.frame.height/3
            wordsToClick.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClick.last!.layer.shadowRadius = 1
            wordsToClick.last!.layer.shadowOpacity = 0.5
            wordsToClick.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClick.last!.titleLabel!.textAlignment = .center
            wordsToClick.last!.tag = n
            wordsToClick.last!.addTarget(self, action: #selector(buttonClickedPhrases), for: .touchUpInside)
            //wordsToClick.last!.titleLabel!.font = UIFont(name: "Helvetica", size: 19.0)
            wordsToClick.last!.setTitleColor(UIColor.black, for: .normal)
            
            //setting frame
            wordsToClickFrame.last!.isEnabled = false
            wordsToClickFrame.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.frame.width, height: wordsToClick.last!.frame.height)
            wordsToClickFrame.last!.backgroundColor = UIColor(red: 0.9317, green: 0.9317, blue: 0.9317, alpha: 1)
            wordsToClickFrame.last!.layer.cornerRadius = wordsToClick.last!.frame.height/3
            wordsToClickFrame.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClickFrame.last!.layer.shadowRadius = 1
            wordsToClickFrame.last!.layer.shadowOpacity = 0.5
            wordsToClickFrame.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClickFrame.last!.tag = n
//            for word in wordsToClick {
//                buttonsAtBottom.append(word)
//            }
            buttonsAtBottom = wordsToClick
            self.view.addSubview(wordsToClick.last!)
            self.view.addSubview(wordsToClickFrame.last!)
            view.sendSubviewToBack(wordsToClickFrame.last!)
        }
        //distance top row has to move
        let distanceToRightTop = UIScreen.main.bounds.width - (wordsToClick[3].frame.origin.x + wordsToClick[3].frame.width)
        let distanceToMoveTop = (distanceToRightTop - 50) / 2
        
        //distance bottom row has to move
        let distanceToRightBottom = UIScreen.main.bounds.width - (wordsToClick[7].frame.origin.x + wordsToClick[7].frame.width)
        let distanceToMoveBottom = (distanceToRightBottom - 50) / 2
        
        for button in wordsToClick {
            if(button.tag < 4) {
                button.frame.origin.x += distanceToMoveTop
            } else {
                button.frame.origin.x += distanceToMoveBottom
            }
        }
        for button in wordsToClickFrame {
            if(button.tag < 4) {
                button.frame.origin.x += distanceToMoveTop
            } else {
                button.frame.origin.x += distanceToMoveBottom
            }
        }
        
        textToTranslate.sizeToFit()
        //textToTranslate.center = view.center
        textToTranslate.frame.origin.y = 220
        //hearButton.frame.origin.x = textToTranslate.frame.origin.x - 60
        hearButton.isEnabled = true
        playAudio()
    }
    
    func newPhraseReversed() {
        self.view.addSubview(lines1)
        self.view.addSubview(lines2)
        self.view.addSubview(hearButton)
        currString = Int.random(in: 0 ..< currSlangTranslatedPhrases.count)
        textToTranslate.text = currSlangTranslatedPhrases[currString]
        for button in wordsToClick {
            button.removeFromSuperview()
        }
        for button in wordsToClickFrame {
            button.removeFromSuperview()
        }
        userTranslation.removeAll()
        wordsToTranslate.removeAll()
        wordsToClick.removeAll()
        wordsToClickFrame.removeAll()
        buttonsAtTop.removeAll()
        buttonsAtBottom.removeAll()
        wordsToTranslate = currSlangOrigPhrases[currString].components(separatedBy: " ")
        while(wordsToTranslate.count < 8) {
            let randomWord = randomOrigWordArray[currLanguage][Int.random(in: 0 ... randomOrigWordArray[currLanguage].count - 1)]
            if(wordsToTranslate.contains(randomWord)) {
                continue
            }
            wordsToTranslate.append(randomWord)
        }
        wordsToTranslate.shuffle()
        for n in 0 ..< wordsToTranslate.count {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 550, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: 50, y: 550, width: 0, height: 0)))
            } else if(n<4) {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 550, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 550, width: 0, height: 0)))
            } else if(n==4){
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 600, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: 50, y: 600, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
                wordsToClickFrame.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 600, width: 0, height: 0)))
            }
            wordsToClick.last!.setTitle(wordsToTranslate[n], for: .normal)
            wordsToClick.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.titleLabel!.intrinsicContentSize.width + 16, height: wordsToClick.last!.titleLabel!.intrinsicContentSize.height + 8)
            //wordsToClick.last!.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
            wordsToClick.last!.backgroundColor = UIColor.white
            wordsToClick.last!.layer.borderWidth = 1.0
            wordsToClick.last!.layer.borderColor = UIColor.lightGray.cgColor
            wordsToClick.last!.layer.cornerRadius = wordsToClick.last!.frame.height/3
            wordsToClick.last!.layer.shadowColor = UIColor.lightGray.cgColor
            wordsToClick.last!.layer.shadowRadius = 1
            wordsToClick.last!.layer.shadowOpacity = 0.5
            wordsToClick.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClick.last!.titleLabel!.textAlignment = .center
            wordsToClick.last!.tag = n
            wordsToClick.last!.addTarget(self, action: #selector(buttonClickedPhrases), for: .touchUpInside)
            //wordsToClick.last!.titleLabel!.font = UIFont(name: "Helvetica", size: 19.0)
            wordsToClick.last!.setTitleColor(UIColor.black, for: .normal)
            
            
            //setting frame
            wordsToClickFrame.last!.isEnabled = false
            wordsToClickFrame.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.frame.width, height: wordsToClick.last!.frame.height)
            wordsToClickFrame.last!.backgroundColor = UIColor(red: 0.9317, green: 0.9317, blue: 0.9317, alpha: 1)
            wordsToClickFrame.last!.layer.cornerRadius = wordsToClick.last!.frame.height/3
            wordsToClickFrame.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClickFrame.last!.layer.shadowRadius = 1
            wordsToClickFrame.last!.layer.shadowOpacity = 0.5
            wordsToClickFrame.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClickFrame.last!.tag = n
            //            for word in wordsToClick {
            //                buttonsAtBottom.append(word)
            //            }
            buttonsAtBottom = wordsToClick
            self.view.addSubview(wordsToClick.last!)
            self.view.addSubview(wordsToClickFrame.last!)
            view.sendSubviewToBack(wordsToClickFrame.last!)
        }
        
        //distance top row has to move
        let distanceToRightTop = UIScreen.main.bounds.width - (wordsToClick[3].frame.origin.x + wordsToClick[3].frame.width)
        let distanceToMoveTop = (distanceToRightTop - 50) / 2
        
        //distance bottom row has to move
        let distanceToRightBottom = UIScreen.main.bounds.width - (wordsToClick[7].frame.origin.x + wordsToClick[7].frame.width)
        let distanceToMoveBottom = (distanceToRightBottom - 50) / 2
        
        for button in wordsToClick {
            if(button.tag < 4) {
                button.frame.origin.x += distanceToMoveTop
            } else {
                button.frame.origin.x += distanceToMoveBottom
            }
        }
        for button in wordsToClickFrame {
            if(button.tag < 4) {
                button.frame.origin.x += distanceToMoveTop
            } else {
                button.frame.origin.x += distanceToMoveBottom
            }
        }
        
        textToTranslate.sizeToFit()
        //textToTranslate.center = view.center
        textToTranslate.frame.origin.y = 220
        hearButton.isEnabled = false
        //hearButton.frame.origin.x = textToTranslate.frame.origin.x - 60
    }
    
    func newWordPairer() {
        numCorrectTapPairs = 0
        checkButton.isEnabled = false
        checkButton.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        checkButton.setTitle("Next", for: .normal)
        let random1 = Int.random(in: 0 ... currSlangOrigWords.count - 1)
        var random2 = random1
        var random3 = random1
        var random4 = random1
        while(random2 == random1) {
            random2 = Int.random(in: 0 ... currSlangOrigWords.count - 1)
        }
        while(random3 == random1 || random3 == random2) {
            random3 = Int.random(in: 0 ... currSlangOrigWords.count - 1)
        }
        while(random4 == random1 || random4 == random2 || random4 == random3) {
            random4 = Int.random(in: 0 ... currSlangOrigWords.count - 1)
        }
        var wordsOrig = [currSlangOrigWords[random1], currSlangOrigWords[random2], currSlangOrigWords[random3], currSlangOrigWords[random4]]
        var wordsTranslated = [currSlangTranslatedWords[random1], currSlangTranslatedWords[random2], currSlangTranslatedWords[random3], currSlangTranslatedWords[random4]]
        indexesOfWordsTapPairs = wordsOrig
        textToTranslate.text = "Tap the pairs"
        wordsOrig.shuffle()
        wordsTranslated.shuffle()
        for button in wordsToClick {
            button.removeFromSuperview()
        }
        for button in wordsToClickFrame {
            button.removeFromSuperview()
        }
        userTranslation.removeAll()
        wordsToTranslate.removeAll()
        wordsToClick.removeAll()
        buttonsAtTop.removeAll()
        buttonsAtBottom.removeAll()
        //wordsToTranslate = currSlangTranslatedPhrases[currString].components(separatedBy: " ")
        for n in 0 ..< 8 {
            if(n == 0) {
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 360, width: 0, height: 0)))
            } else if(n<4) {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 360, width: 0, height: 0)))
            } else if(n==4){
                wordsToClick.append(UIButton(frame: CGRect(x: 50, y: 410, width: 0, height: 0)))
            } else {
                wordsToClick.append(UIButton(frame: CGRect(x: wordsToClick[n-1].frame.origin.x + wordsToClick[n-1].frame.width + 15, y: 410, width: 0, height: 0)))
            }
            if(n < 4) {
                wordsToClick.last!.setTitle(wordsOrig[n], for: .normal)
            } else {
                wordsToClick.last!.setTitle(wordsTranslated[n-4], for: .normal)
            }
            wordsToClick.last!.frame = CGRect(x: wordsToClick.last!.frame.origin.x, y: wordsToClick.last!.frame.origin.y, width: wordsToClick.last!.titleLabel!.intrinsicContentSize.width + 16, height: wordsToClick.last!.titleLabel!.intrinsicContentSize.height + 8)
            //wordsToClick.last!.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
            wordsToClick.last!.backgroundColor = UIColor.white
            wordsToClick.last!.layer.borderWidth = 1.0
            wordsToClick.last!.layer.borderColor = UIColor.lightGray.cgColor
            wordsToClick.last!.layer.cornerRadius = wordsToClick.last!.frame.height/3
            wordsToClick.last!.layer.shadowColor = UIColor.darkGray.cgColor
            wordsToClick.last!.layer.shadowRadius = 1
            wordsToClick.last!.layer.shadowOpacity = 0.5
            wordsToClick.last!.layer.shadowOffset = CGSize(width: 0, height: 0)
            wordsToClick.last!.titleLabel!.textAlignment = .center
            wordsToClick.last!.tag = n
            wordsToClick.last!.addTarget(self, action: #selector(buttonClickedWords), for: .touchUpInside)
            //wordsToClick.last!.titleLabel!.font = UIFont(name: "Helvetica", size: 19.0)
            wordsToClick.last!.setTitleColor(UIColor.black, for: .normal)
            //            for word in wordsToClick {
            //                buttonsAtBottom.append(word)
            //            }
            self.view.addSubview(wordsToClick.last!)
        }
        
        //distance top row has to move
        let distanceToRightTop = UIScreen.main.bounds.width - (wordsToClick[3].frame.origin.x + wordsToClick[3].frame.width)
        let distanceToMoveTop = (distanceToRightTop - 50) / 2
        
        //distance bottom row has to move
        let distanceToRightBottom = UIScreen.main.bounds.width - (wordsToClick[7].frame.origin.x + wordsToClick[7].frame.width)
        let distanceToMoveBottom = (distanceToRightBottom - 50) / 2
        
        for button in wordsToClick {
            if(button.tag < 4) {
                button.frame.origin.x += distanceToMoveTop
            } else {
                button.frame.origin.x += distanceToMoveBottom
            }
        }
        
        textToTranslate.sizeToFit()
        //textToTranslate.center = view.center
        textToTranslate.frame.origin.y = 220
    }
    
    @objc func buttonClickedWords(sender: UIButton!) {
        //if currently no button is selected
        if(currWordSelected == nil) {
            currWordSelected = sender
            //if newly chosen button is in origLanguage (top)
            if(sender.frame.origin.y == 360) {
                currWordSelectedOrig = true
                //if newly chosen button is in translatedLanguage (bottom)
            } else {
                currWordSelectedOrig = false
            }
            sender.backgroundColor = UIColor(red: 0.5, green: 0.778, blue: 0.778, alpha: 1)
        //if there is already a button selected
        } else {
            //if the previously selected button is origLanguage
            if(currWordSelectedOrig == true) {
                //if previously and newly selected buttons are both on top, just change currSelected to new
                if(sender.frame.origin.y == 360) {
                    currWordSelected.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
                    sender.backgroundColor = UIColor(red: 0.5, green: 0.778, blue: 0.778, alpha: 1)
                    currWordSelected = sender
                //check if it is the correct translation
                } else {
                    let ind = languagesOrigWords[currLanguage].firstIndex(of: currWordSelected.titleLabel!.text!)!
                    //if translation is correct
                    if(sender.titleLabel!.text! == languagesTranslatedWords[currLanguage][ind]) {
                        UIView.animate(withDuration: 0.2, animations: {
                            currWordSelected.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.478, alpha: 1)
                            sender.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.478, alpha: 1)
                        })
                        sender.isEnabled = false
                        currWordSelected.isEnabled = false
                        currWordSelected = nil
                        numCorrectTapPairs += 1
                        for word in indexesOfWordsTapPairs {
                            if(currSlangTranslatedWords.contains(sender.titleLabel!.text!)) {
                                if(currSlangOrigWords[currSlangTranslatedWords.firstIndex(of: sender.titleLabel!.text!)!] == word) {
                                    let ind2 = currSlangOrigWords.firstIndex(of: word)!
                                    currSlangOrigWords.remove(at: ind2)
                                    currSlangTranslatedWords.remove(at: ind2)
                                }
                            }
                        }
                        if(numCorrectTapPairs >= 4) {
                            turnCheckToNext()
                        }
                        //if translation is incorrect
                    } else {
                        UIView.animate(withDuration: 0.2, animations: {
                            currWordSelected.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                            sender.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                        })
                        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                            currWordSelected.backgroundColor = UIColor.white
                            sender.backgroundColor = UIColor.white
                        })
                        currWordSelected = nil
                    }
                }
                //if previously selected button is translatedLanguage
            } else {
                //if previously and newly selected buttons are both on bottom, just change currSelected to new
                if(sender.frame.origin.y == 410) {
                    currWordSelected.backgroundColor = UIColor(red: 1, green: 0.478, blue: 0.478, alpha: 1)
                    sender.backgroundColor = UIColor(red: 0.5, green: 0.778, blue: 0.778, alpha: 1)
                    currWordSelected = sender
                    //check translation
                } else {
                    let ind = languagesTranslatedWords[currLanguage].firstIndex(of: currWordSelected.titleLabel!.text!)!
                    //if translation is correct
                    if(sender.titleLabel!.text! == languagesOrigWords[currLanguage][ind]) {
                        UIView.animate(withDuration: 0.2, animations: {
                            currWordSelected.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.478, alpha: 1)
                            sender.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.478, alpha: 1)
                        })
                        sender.isEnabled = false
                        currWordSelected.isEnabled = false
                        currWordSelected = nil
                        numCorrectTapPairs += 1
                        for word in indexesOfWordsTapPairs {
                            if(sender.titleLabel!.text! == word) {
                                if(currSlangOrigWords.contains(word)) {
                                    let ind2 = currSlangOrigWords.firstIndex(of: word)!
                                    currSlangOrigWords.remove(at: ind2)
                                    currSlangTranslatedWords.remove(at: ind2)
                                }
                            }
                        }
                        if(numCorrectTapPairs >= 4) {
                            turnCheckToNext()
                        }
                        //if translation is incorrect
                    } else {
                        UIView.animate(withDuration: 0.2, animations: {
                            currWordSelected.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                            sender.backgroundColor = UIColor(red: 1, green: 0.2, blue: 0.2, alpha: 1)
                        })
                        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
                            currWordSelected.backgroundColor = UIColor.white
                            sender.backgroundColor = UIColor.white
                        })
                        currWordSelected = nil
                    }
                }
            }
        }
    }
    
    @objc func buttonClickedPhrases(sender: UIButton!) {
        if(sender.frame.origin.y >= 550) {
            let ind = buttonsAtBottom.firstIndex(of: sender)!
            buttonsAtBottom.remove(at: ind)
            /*
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
//                    buttonsAtBottom[3].frame.origin.y = 550
                    dest.x = buttonsAtBottom[2].frame.origin.x + buttonsAtBottom[2].frame.width + 15
                    dest.y = 550
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[3].frame = CGRect(x: dest.x, y: dest.y, width: buttonsAtBottom[3].frame.size.width, height: buttonsAtBottom[3].frame.size.height)
                    })
                }
                if(n == 4) {
                    UIView.animate(withDuration: 0.2, animations: {
                        buttonsAtBottom[4].frame = CGRect(x: 50, y: buttonsAtBottom[4].frame.origin.y, width: buttonsAtBottom[4].frame.size.width, height: buttonsAtBottom[4].frame.size.height)
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
                        buttonsAtBottom[n].frame = CGRect(x: 50, y: buttonsAtBottom[n].frame.origin.y, width: buttonsAtBottom[n].frame.size.width, height: buttonsAtBottom[n].frame.size.height)
                    })
                }
            }
            */
            //buttonsAtBottom.remove(at: buttonsAtBottom.firstIndex(of: sender)!)
            var dest = CGPoint(x: 0, y: 0)
            if(userTranslation.count == 0 || buttonsAtTop.count == 4) {
                //sender.frame.origin.x = 100
                dest.x = 50
            } else {
                //sender.frame.origin.x = buttonsAtTop.last!.frame.origin.x + buttonsAtTop.last!.frame.width + 15
                dest.x = buttonsAtTop.last!.frame.origin.x + buttonsAtTop.last!.frame.width + 15
            }
            if(buttonsAtTop.count < 4) {
                //sender.frame.origin.y = 300
                dest.y = 300
            } else {
                //sender.frame.origin.y = 400
                dest.y = 350
            }
            UIView.animate(withDuration: 0.2, animations: {
                sender.frame = CGRect(x: dest.x, y: dest.y, width: sender.frame.size.width, height: sender.frame.size.height)
            })
            buttonsAtTop.append(sender)
            userTranslation.append(sender.titleLabel!.text!)
        } else if(sender.frame.origin.y <= 400) {
            let ind = buttonsAtTop.firstIndex(of: sender)!
            buttonsAtTop.remove(at: ind)
            /*
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
                        buttonsAtTop[4].frame = CGRect(x: 50, y: buttonsAtTop[4].frame.origin.y, width: buttonsAtTop[4].frame.size.width, height: buttonsAtTop[4].frame.size.height)
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
                        buttonsAtTop[n].frame = CGRect(x: 50, y: buttonsAtTop[n].frame.origin.y, width: buttonsAtTop[n].frame.size.width, height: buttonsAtTop[n].frame.size.height)
                    })
                }
            } */
            //buttonsAtTop.remove(at: buttonsAtTop.firstIndex(of: sender)!)
            let dest = CGPoint(x: wordsToClickFrame[sender.tag].frame.origin.x, y: wordsToClickFrame[sender.tag].frame.origin.y)
//            if(buttonsAtBottom.count == 0 || buttonsAtBottom.count == 4) {
//                //sender.frame.origin.x = 100
//                dest.x = 50
//            } else {
//                //sender.frame.origin.x = buttonsAtBottom.last!.frame.origin.x + buttonsAtBottom.last!.frame.width + 15
//                dest.x = buttonsAtBottom.last!.frame.origin.x + buttonsAtBottom.last!.frame.width + 15
//            }
//            if(buttonsAtBottom.count < 4) {
//                //sender.frame.origin.y = 550
//                dest.y = 550
//            } else {
//                //sender.frame.origin.y = 600
//                dest.y = 600
//            }
            UIView.animate(withDuration: 0.2, animations: {
                sender.frame = CGRect(x: dest.x, y: dest.y, width: sender.frame.size.width, height: sender.frame.size.height)
            })
            buttonsAtBottom.append(sender)
//            var rightMostIndex = 0
//            var rightMostXValue = 0
//            for n in 0 ..< wordsToClick.count {
//                if(wordsToClick[n].frame.origin.y == 550 && rightMostXValue < Int(wordsToClick[n].frame.origin.x)) {
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
    
    @IBAction func backButtonClicked(sender: UIButton!) {
//        let chooseLangScreen = self.storyboard?.instantiateViewController(withIdentifier: "TabController") as! UITabBarController
//        self.present(chooseLangScreen, animated: true, completion: nil)
        
        //this is here for testing purposes. in future, should be when each lesson is finished or something like that, so if the user quits midway they don't get score added
        let currUserData = db.collection("users").document(Auth.auth().currentUser!.uid)
        currUserData.updateData([
            "score": UserDefaults.standard.integer(forKey: "UserScore")
        ]) { err in
            if let err = err {
                print("Error updating score: \(err)")
            } else {
                print("Score successfully updated")
                self.performSegue(withIdentifier: "learnToLanguage", sender: self)
            }
        }
    }
    
    func correct() {
        lastCorrect = true
        score += 100
        UserDefaults.standard.set(score, forKey: "UserScore")
        let promptsLeft = Float(currSlangOrigPhrases.count) + Float(currSlangOrigWords.count) / 4
        UIView.animate(withDuration: 0.2, animations: {
            self.correctPopup.frame.origin.y = 730
            self.progressBar.setProgress(Float(Float(initialAmountToLearn) - promptsLeft)/Float(initialAmountToLearn), animated: true)
        })
    }
    
    func incorrect() {
        lastCorrect = false
        UIView.animate(withDuration: 0.2, animations: {
            self.incorrectPopup.frame.origin.y = 730
        })
    }
    
    func turnCheckToNext() {
        if(checkButton.isEnabled == false) {
            checkButton.isEnabled = true
        }
        checkButton.backgroundColor = UIColor(red: 0.39, green: 0.635, blue: 0.94, alpha: 1)
        readyForNext = true
        checkButton.setTitle("Next", for: .normal)
        correct()
    }
    
    @IBAction func checkButtonClicked(sender: UIButton!) {
        if(readyForNext == false) {
            let finalTranslation = userTranslation.joined(separator: " ")
            if(promptType == 0) {
                if(finalTranslation == currSlangTranslatedPhrases[currString]) {
                    print("Correct!")
                    currSlangOrigPhrases.remove(at: currString)
                    currSlangTranslatedPhrases.remove(at: currString)
                    turnCheckToNext()
                    for word in wordsToClick {
                        word.isEnabled = false
                    }
                } else {
                    print("Given: " + finalTranslation)
                    print("Expected: " + currSlangTranslatedPhrases[currString])
                    print("Incorrect!")
                    incorrect()
                    readyForNext = true
                    checkButton.setTitle("Next", for: .normal)
                }
            } else if(promptType == 1) {
                if(finalTranslation == currSlangOrigPhrases[currString]) {
                    print("Correct!")
                    playAudio()
                    currSlangOrigPhrases.remove(at: currString)
                    currSlangTranslatedPhrases.remove(at: currString)
                    hearButton.isEnabled = true
                    turnCheckToNext()
                    for word in wordsToClick {
                        word.isEnabled = false
                    }
                } else {
                    print("Given: " + finalTranslation)
                    print("Expected: " + currSlangOrigPhrases[currString])
                    print("Incorrect!")
                    UIView.animate(withDuration: 0.2, animations: {
                        self.incorrectPopup.frame.origin.y = 730
                    })
                    incorrect()
                    readyForNext = true
                    checkButton.setTitle("Next", for: .normal)
                }
            }
        } else {
            if(lastCorrect && currSlangOrigPhrases.count > 0 && (promptType == 0 || promptType == 1)) {
                //remove curr audioclip here rather than in checkButtonClicked like other arrays because user may still press the Hear button after the translation is checked
                currAudioClipsPhrases.remove(at: currString)
            }
            if(currSlangOrigPhrases.count + currSlangOrigWords.count > 0) {
                newPrompt()
            } else {
                //THIS HAPPENS WHEN IT IS FINISHED, SHOULD GO BACK TO PREVIOUS PAGE
                //temporarily just restart current lesson
                startLearning()
            }
        }
    }
    
    @IBAction func hearButtonClicked(sender: UIButton!) {
        playAudio()
    }
    
    //learned how to play audio from: https://stackoverflow.com/questions/32036146/how-to-play-a-sound-using-swift
    func playAudio() {
        guard let url = Bundle.main.url(forResource: currAudioClipsPhrases[currString], withExtension: "mp3") else {
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

