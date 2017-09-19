//
//  ViewController.swift
//  StarWars
//
//  Created by Iman Zarrabian on 19/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var starwarsTableView: UITableView!
    
    let starWarsFirstNameData = ["Luke", "Han", "Leia", "Anakin", "Obiwan", "R2"]
    let starWarsLastNameData = ["Skywalker", "Solo", "Skywalker", "Skywalker", "Kenoby", "D2"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier { //optional binding
            if id == "DetailViewControllerSegue" {
                let destVC = segue.destination
                
                if let cell = sender as? UITableViewCell,
                    let indexPath = starwarsTableView.indexPath(for: cell) { //optional binding double
                    destVC.title = starWarsFirstNameData[indexPath.row]
                }
            }
        }
    }
}

//MARK: UITableViewDataSource requirements
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starWarsFirstNameData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "starwarsCell", for: indexPath)
        
        cell.textLabel?.text = starWarsFirstNameData[indexPath.row]
        cell.detailTextLabel?.text = starWarsLastNameData[indexPath.row]
        
        return cell
    }
}

//MARK: UITableViewDelegate requirements
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

