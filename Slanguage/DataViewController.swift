//
//  DataViewController.swift
//  Project 3
//
//  Created by Dylan Telson on 10/14/19.
//  Copyright © 2019 Dylan Telson. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""


    override func viewDidLoad() {
        //after loading
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


}
