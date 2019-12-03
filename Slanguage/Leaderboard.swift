//
//  Leaderboard.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/26/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Scores {
    var name = ""
    var score = 0
    init(userName: String, userScore: Int) {
        self.name = userName
        self.score = userScore
    }
}

class myCell: UITableViewCell {
    
    // Define label, textField etc
    var aMap: UILabel!
    var aVal : UILabel!
    
    // Setup your objects
    func setUpCell() {
        aMap = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: 50))
        aMap.textAlignment = .left
        self.contentView.addSubview(aMap)
        
        aVal = UILabel(frame: CGRect(x: self.frame.width - 125, y: 0, width: 200, height: 50))
        aVal.textAlignment = .right
        self.contentView.addSubview(aVal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

class Leaderboard: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    var scoresArray = [Scores]()
//    var data = ["Dylan": 4200,
//                "Jacob": 1700,
//                "John": 1200,
//                "Sarah": 9100,
//                "Kaleigh": 200,
//                "Justin": 4000,
//                "Ray": 100,
//                "Maddy": 15000,
//                "Jessica": 300,
//                "Hamburger": 700,
//                "Croissant": 47000,
//                "Rachel": 5000]
    
    override func viewDidLoad() {
        let group = DispatchGroup()
        group.enter()
        
        Firestore.firestore().collection("users").order(by: "score", descending: true).limit(to: 20)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let name = document["username"] as! String
                        let score = document["score"] as! Int
                        let aScore = Scores(userName: name, userScore: score)
                        self.scoresArray.insert(aScore, at: 0)
                    }
                    self.scoresArray.reverse()
                    group.leave()
                }
        }
//        let userScore = UserDefaults.standard.integer(forKey: "UserScore")
//        if(userScore == nil) {
//            data["You"] = 0
//        } else {
//            data["You"] = UserDefaults.standard.integer(forKey: "UserScore")
//        }
        group.notify(queue: DispatchQueue.main) {
            super.viewDidLoad()
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:myCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? myCell
        
        //if cell == nil {
            cell = myCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        //}
        let cellName = scoresArray[indexPath.row].name
        let cellValue = scoresArray[indexPath.row].score
        cell?.setUpCell()
        cell!.aMap.text = cellName
        cell!.aVal.text = String(cellValue)
        if(cellName == UserDefaults.standard.string(forKey: "UserName")) {
            cell!.aMap.textColor = UIColor.blue
            cell!.aVal.textColor = UIColor.blue
        }
        return cell!
    }
}
