//
//  DetailViewController.swift
//  Demo1Formation
//
//  Created by Iman Zarrabian on 18/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

class DetailViewController: DebuggableViewController {
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    //MODEL
    var titleString: String!
    var color: UIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("toto".whoami())
        mainTitleLabel.text = titleString
        view.backgroundColor = color

    }
}
