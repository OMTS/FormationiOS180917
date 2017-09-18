//
//  DebuggableViewController.swift
//  Demo1Formation
//
//  Created by Iman Zarrabian on 18/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

class DebuggableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let classDescription = String.className(instance: self)
        print(classDescription + " viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(String(describing: self) + " viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(String(describing: self) + " viewWillAppear")
    }
}

extension String {
    static func className(instance: Any) -> String {
        let fullName = String(describing: instance)
        let components = fullName.components(separatedBy: ".")
        if components.count > 1 {
            let rightComponents = components[1].components(separatedBy: ":")
            if rightComponents.count > 0 {
                return rightComponents[0]
            }
        }
        return fullName
    }
}
