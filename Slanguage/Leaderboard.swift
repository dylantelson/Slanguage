//
//  Leaderboard.swift
//  Project 3 CS441
//
//  Created by Dylan Telson on 10/26/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import Foundation
import UIKit

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
}

class Leaderboard: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView : UITableView!
    
    var data = ["Dylan": 4200,
                "Jacob": 1700,
                "John": 1200,
                "Sarah": 9100,
                "Kaleigh": 200,
                "Justin": 4000,
                "Ray": 100,
                "Maddy": 15000,
                "Jessica": 300,
                "Hamburger": 700,
                "Croissant": 47000,
                "Rachel": 5000]
    
    override func viewDidLoad() {
        let userScore = UserDefaults.standard.integer(forKey: "UserScore")
        if(userScore == nil) {
            data["You"] = 0
        } else {
            data["You"] = UserDefaults.standard.integer(forKey: "UserScore")
        }
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:myCell? = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? myCell
        
        if cell == nil {
            
            cell = myCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        var sortedDict = (Array(data).sorted {$0.1 > $1.1})
        let cellName = sortedDict[indexPath.row].0
        let cellValue = sortedDict[indexPath.row].1
        cell?.setUpCell()
        cell!.aMap.text = cellName
        cell!.aVal.text = String(cellValue)
        if(cellName == "You") {
            cell!.aMap.textColor = UIColor.blue
            cell!.aVal.textColor = UIColor.blue
        }
        return cell!
    }
    
}
