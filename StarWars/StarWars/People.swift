//
//  People.swift
//  StarWars
//
//  Created by Eddy Claessens on 20/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import Foundation
import Alamofire

class People {

    var id = ""
    
    enum Gender: Int {
        case male
        case female
        case other
    }

    var firstname = ""
    var lastname = ""

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
    
    init(hash: [String: Any]) {
        updateObject(fromHash: hash)
    }

    
    func updateObject(fromHash hash: [String: Any]) {
        if let id = hash["url"] as? String {
            self.id = id
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
    }
    
    static func all(completionHandler: @escaping ([People]) -> ()) {

        Alamofire.request(Constants.Remote.kBaseURL + Constants.Remote.kPeoplePath).responseJSON { response in
            
            if let json = response.result.value {
                
                if let hash = json as? [String : Any],
                    let resultArray = hash["results"] {
                    
                    guard let array = resultArray as? [ [String: Any] ] else {
                        return
                    }
                    //array c'est un tableau de people (dict) => tableau de People
                    let tmp = array.map { (dict) -> People in
                        return People(hash: dict)
                    }
                    
                    completionHandler(tmp)
                }
            }
        }
    }
    
    func update(completionHandler: @escaping () -> ()) {
        Alamofire.request(self.id).responseJSON { response in
            if let json = response.result.value {

                if let hash = json as? [String : Any] {
                     self.updateObject(fromHash: hash)
                     completionHandler()
                }
            }
        }
    }
}
