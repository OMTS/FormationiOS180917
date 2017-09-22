//
//  ViewController.swift
//  StarWars
//
//  Created by Iman Zarrabian on 19/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var starwarsTableView: UITableView!

    var starWarsPeople: Results<People>?
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        starwarsTableView.estimatedRowHeight = 78
        starwarsTableView.rowHeight = UITableViewAutomaticDimension
        realm = try! Realm()

       /* DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            print("? - IS RUNNING IN BG")
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).sync {
            print("1 - IS RUNNING IN CURRENT QUEUE")
        }
        
        DispatchQueue.main.async {
            print("3 - IS RUNNING IN THREAD 1 (UI THREAD)")
        }
        
        print("2 - continues the code")
         */
        fetchAndUpdateLocalData()
        
        People.all { _ in
            self.fetchAndUpdateLocalData()
        }
    }
    
    func fetchAndUpdateLocalData() {
        self.starWarsPeople = realm.objects(People.self)
        self.starwarsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier { //optional binding
            if id == "DetailViewControllerSegue" {
                if let cell = sender as? UITableViewCell,
                    let destVC = segue.destination as? PeopleViewController,
                    let indexPath = starwarsTableView.indexPath(for: cell) { //optional binding double
                    destVC.people = starWarsPeople![indexPath.row]
                }
            }
        }
    }
}

//MARK: UITableViewDataSource requirements
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starWarsPeople?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starwarsCell", for: indexPath) as! PeopleTableViewCell
        
        let people = starWarsPeople![indexPath.row]
        cell.nameLabel.text = people.nickname
            
        cell.pictureImageView.sd_setImage(with: URL(string: people.photoURL), placeholderImage: UIImage(named: "ph"))
        return cell
    }
}

//MARK: UITableViewDelegate requirements
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




