//
//  FavViewController.swift
//  StarWars
//
//  Created by Iman Zarrabian on 22/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit
import RealmSwift

class FavViewController: UIViewController {
    var starWarsPeopleFav: Results<People>?
    @IBOutlet weak var starwarsFavTableView: UITableView!
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        starwarsFavTableView.estimatedRowHeight = 78
        starwarsFavTableView.rowHeight = UITableViewAutomaticDimension
        realm = try! Realm()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLocalData()
    }
    
    func fetchLocalData() {
        self.starWarsPeopleFav = realm.objects(People.self).filter("isFavorite == true")
        self.starwarsFavTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier { //optional binding
            if id == "DetailViewControllerFavSegue" {
                if let cell = sender as? UITableViewCell,
                    let destVC = segue.destination as? PeopleViewController,
                    let indexPath = starwarsFavTableView.indexPath(for: cell) { //optional binding double
                    destVC.people = starWarsPeopleFav![indexPath.row]
                }
            }
        }
    }
}



//MARK: UITableViewDataSource requirements
extension FavViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starWarsPeopleFav?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starwarsCellFav", for: indexPath) as! PeopleTableViewCell
        
        let people = starWarsPeopleFav![indexPath.row]
        cell.nameLabel.text = people.nickname
        
        cell.pictureImageView.sd_setImage(with: URL(string: people.photoURL), placeholderImage: UIImage(named: "ph"))
        return cell
    }
}

//MARK: UITableViewDelegate requirements
extension FavViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
