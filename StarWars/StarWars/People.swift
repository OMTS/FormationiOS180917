//
//  People.swift
//  StarWars
//
//  Created by Eddy Claessens on 20/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class People: Object {

    var delegate: PeopleUpdateDelegate?
    
    dynamic var id = ""
    
    enum Gender: Int {
        case male
        case female
        case other
    }

    dynamic var firstname = ""
    dynamic var lastname = ""
    dynamic var isFavorite: Bool = false

    var movies = [String]()
    var bio = "" // not in SWAPI

    var alive = true // not in SWAPI

    var gender: Gender = .other

    var birthdate: Int = 0
    
    var nickname: String {
        get {
            return firstname + " " + lastname
        }
        set {
            let components = newValue.components(separatedBy: " ")
            firstname = components.first ?? "" //nil coaliscing operator
            lastname = components.last ?? "" //nil coaliscing operator
        }
    }
    
    dynamic var photoURL: String = ""
    
    override static func ignoredProperties() -> [String] {
        return ["movies", "bio", "alive", "gender", "birthdate", "nickname", "delegate"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func updateObject(fromHash hash: [String: Any]) {
        if self.realm == nil {
            if let id = hash["url"] as? String  {
                self.id = id
            }
        }

        if let name = hash["name"] as? String {
            self.nickname = name
        }
        
        if let gender = hash["gender"] as? String {
            if gender == "male" {
                self.gender = .male
            } else if gender == "female" {
                self.gender = .female
            } else {
                self.gender = .other
            }
        }
        
        self.movies = ["https://lumiere-a.akamaihd.net/v1/images/lazada-starwars-1-1_741cd5d6.jpeg?region=0%2C0%2C1000%2C1000&width=320",
                       "https://i.pinimg.com/736x/87/1c/4a/871c4ad41bcd695d1476d8e0d6e7e32a--star-wars-stormtrooper-darth-vader.jpg",
                       "http://img0.gtsstatic.com/star-wars/star-wars-vii_164500_w460.jpg"]
        
        photoURL = movies.first!
    }
    
    static func all(completionHandler: @escaping ([People]) -> ()) {

        Alamofire.request(Constants.Remote.kBaseURL + Constants.Remote.kPeoplePath).responseJSON { response in
            
            if let json = response.result.value {
                
                if let hash = json as? [String : Any],
                    let resultArray = hash["results"] {
                    
                    guard let array = resultArray as? [ [String: Any] ] else {
                        return
                    }
                    // Get the default Realm
                    let realm = try! Realm()
                    // You only need to do this once (per thread)
                    
                    
                   
                    //array c'est un tableau de people (dict) => tableau de People
                    let tmp = array.map { (dict) -> People in
                       
                        if let people = realm.object(ofType: People.self, forPrimaryKey: dict["url"]) {
                            try! realm.write {
                                people.updateObject(fromHash: dict)
                            }
                            return people
                        } else {
                            let people = People()
                            people.updateObject(fromHash: dict)
                            // Add to the Realm inside a transaction

                            try! realm.write {
                                realm.create(People.self, value: people, update: true)
                            }
                            return people
                        }
                    }
                    
                    //equivalent
                    //let tmp = array.map { People(hash: $0) }                    
                    completionHandler(tmp)
                }
            }
        }
    }
    
    func update() {
        Alamofire.request(self.id).responseJSON { response in
            if let json = response.result.value {

                if var hash = json as? [String : Any] {
                    try! self.realm!.write {
                        self.updateObject(fromHash: hash)
                    }
                    // self.delegate?.didUpdatePeople(people: self) // DELEGATE FASHION
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PeopleUpdated"), object: self, userInfo: ["people": self]) // NOTIFICATION OLD FASHION
                }
            }
        }
    }
}


protocol PeopleUpdateDelegate {
    func didUpdatePeople(people: People)
}

