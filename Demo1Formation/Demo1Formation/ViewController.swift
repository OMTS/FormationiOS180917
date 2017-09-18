//
//  ViewController.swift
//  Demo1Formation
//
//  Created by Iman Zarrabian on 18/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

class ViewController: DebuggableViewController {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var returnedDataLabel: UILabel!
    
    let arrayOfColors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.backgroundColor = UIColor.green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonTapped(UIButton())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonTapped(UIButton())
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "showSegue" {
                if let destVC = segue.destination as? DetailViewController {
                    print("segue")
                    destVC.titleString = "TOTO"
                    destVC.color = colorView.backgroundColor!
                }
            } else if id == "ModalViewControllerSegue" {
                if let destVC = segue.destination as? ModalViewController {
                    destVC.delegate = self
                }
            }
        }
    }
}

extension ViewController {
    @IBAction func buttonTapped(_ sender: UIButton) {
        let index = Int(arc4random() % 5)
        let color = arrayOfColors[index]
        colorView.backgroundColor = color
    }
}

extension ViewController {
    func foo() {
        
    }
}

extension String {
    func whoami() -> String {
        return "I am a " + self + " String"
    }
}

//MARK: ModalViewControllerDelegate Delegates methods
extension ViewController: ModalViewControllerDelegate {
    func didFinishDisplayingWithText(text: String) {
        returnedDataLabel.text = text
    }
}
