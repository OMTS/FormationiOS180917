//
//  ViewController.swift
//  GestureDemo
//
//  Created by Iman Zarrabian on 21/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorChangingView: UIView!
    let arrayOfColors = [UIColor.black, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeColor))
        tapGesture.numberOfTapsRequired = 3
        tapGesture.numberOfTouchesRequired = 1
        colorChangingView.addGestureRecognizer(tapGesture)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panOccured))
        colorChangingView.addGestureRecognizer(panGesture)
        
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeColor(tapGesture: UITapGestureRecognizer) {
        print(tapGesture)
        let index = Int(arc4random() % 5)
        let color = arrayOfColors[index]
        colorChangingView.backgroundColor = color
    }
    
    @objc func panOccured(panGesture: UIPanGestureRecognizer) {
        print(panGesture.state)
        if panGesture.state == .changed {
            let translation = panGesture.translation(in: view)
            colorChangingView.center = CGPoint(x: colorChangingView.center.x + translation.x , y: colorChangingView.center.y + translation.y )
            
            panGesture.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc func swiped(swipeGesture: UISwipeGestureRecognizer) {
        
    }
    
}

