//
//  PeopleViewController.swift
//  StarWars
//
//  Created by Eddy Claessens on 20/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        title = "\(people.firstname) \(people.lastname)"

        moviesCollectionView.dataSource = self

        genderSegmentedControl.selectedSegmentIndex = people.gender.rawValue

        bioLB.text = people.bio

        isAliveLabel.text = "Is alive"
        isAliveSwitch.isOn = people.alive

        nicknameLB.text = "Nickname"

        birthdateSlider.minimumValue = 1900
        birthdateSlider.maximumValue = 2000

        birthdateSlider.value = Float(people.birthdate)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PeopleViewController.dismissKeyboard))
        scrollView.addGestureRecognizer(tapGestureRecognizer)

        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            // je suis sur iPad
        }
    }

    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(PeopleViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PeopleViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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

        cell.coverImageView.image = UIImage(named: people.movies[indexPath.item])

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
