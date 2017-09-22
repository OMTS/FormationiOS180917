//
//  PeopleViewController.swift
//  StarWars
//
//  Created by Eddy Claessens on 20/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class PeopleViewController: UIViewController {

    var people: People! 

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var favoriteBT: UIButton!

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bioLB: UILabel!
    @IBOutlet weak var isAliveLabel: UILabel!
    @IBOutlet weak var isAliveSwitch: UISwitch!

    @IBOutlet weak var birthdateSlider: UISlider!

    @IBOutlet weak var nicknameLB: UILabel!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        
        // Do any additional setup after loading the view.
        moviesCollectionView.dataSource = self
        birthdateSlider.minimumValue = 1900
        birthdateSlider.maximumValue = 2000
        
        people.delegate = self
        updateUI()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PeopleViewController.dismissKeyboard))
        scrollView.addGestureRecognizer(tapGestureRecognizer)

        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            // je suis sur iPad
        }
        //ABSTRACTION COMPLETE DE LA SOURCE DE LA DONNEE
        people.update()
    }
    
    func handleNotification(notif: Notification) {
        print(notif)
        updateUI()
    }
    
    func updateUI() {
        title = "\(people.firstname) \(people.lastname)"
        
        genderSegmentedControl.selectedSegmentIndex = people.gender.rawValue
        
        bioLB.text = people.bio
        
        isAliveLabel.text = "Is alive"
        isAliveSwitch.isOn = people.alive
        
        nicknameLB.text = "Nickname"
        birthdateSlider.value = Float(people.birthdate)
        
        print(people.isFavorite)
        favoriteBT.isSelected = people.isFavorite
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(PeopleViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PeopleViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(notif:)), name: NSNotification.Name(rawValue: "PeopleUpdated"), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }

    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height - self.tabBarController!.tabBar.frame.size.height

            UIView.animate(withDuration: 0.4, animations: { 
                self.view.layoutIfNeeded()
            })
        }
    }

    func keyboardWillHide(_ notification: Notification) {
        bottomConstraint.constant = 0

        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func favoriteClicked(_ sender: Any) {
        favoriteBT.isSelected = !favoriteBT.isSelected
        try! people.realm!.write {
            people.isFavorite = favoriteBT.isSelected
        }
    }

    @IBAction func aliveChanged(_ sender: Any) {
        let isOn = (sender as! UISwitch).isOn
    }

    @IBAction func genderChanged(_ sender: Any) {

    }

    @IBAction func birthdateChanged(_ sender: Any) {

    }
}

extension PeopleViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell

        let pictureURL = people.movies[indexPath.row]
        cell.coverImageView.sd_setImage(with: URL(string: pictureURL), placeholderImage: UIImage(named: "ph"))
        
        return cell
    }
}

extension PeopleViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
}

extension PeopleViewController: PeopleUpdateDelegate {
    func didUpdatePeople(people: People) {
        updateUI()
    }
}


