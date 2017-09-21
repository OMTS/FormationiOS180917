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

class ViewController: UIViewController {

    @IBOutlet weak var starwarsTableView: UITableView!

    var starWarsPeople = [People]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        starwarsTableView.estimatedRowHeight = 78
        starwarsTableView.rowHeight = UITableViewAutomaticDimension
        
        People.all { newData in
            self.starWarsPeople = newData
            self.starwarsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier { //optional binding
            if id == "DetailViewControllerSegue" {
                if let cell = sender as? UITableViewCell,
                    let destVC = segue.destination as? PeopleViewController,
                    let indexPath = starwarsTableView.indexPath(for: cell) { //optional binding double
                    destVC.people = starWarsPeople[indexPath.row]
                }
            }
        }
    }
}

//MARK: UITableViewDataSource requirements
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starWarsPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starwarsCell", for: indexPath) as! PeopleTableViewCell

        cell.nameLabel.text = starWarsPeople[indexPath.row].nickname
        
        if let movieURL = starWarsPeople[indexPath.row].movies.first {
            cell.pictureImageView.sd_setImage(with: URL(string: movieURL), placeholderImage: UIImage(named: "ph"))
        }

        return cell
    }
}

//MARK: UITableViewDelegate requirements
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




