//
//  ModalViewController.swift
//  Demo1Formation
//
//  Created by Iman Zarrabian on 18/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate {
    func didFinishDisplayingWithText(text: String)
}

class ModalViewController: DebuggableViewController {

    @IBOutlet weak var textField: UITextField!
    var delegate: ModalViewControllerDelegate?
    
    @IBAction func donePressed(_ sender: UIButton) {
        delegate?.didFinishDisplayingWithText(text: textField.text!)
        dismiss(animated: true, completion: nil)
    }
}
