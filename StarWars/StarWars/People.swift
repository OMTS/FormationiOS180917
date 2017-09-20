//
//  People.swift
//  StarWars
//
//  Created by Eddy Claessens on 20/09/2017.
//  Copyright © 2017 One More Thing Studio. All rights reserved.
//

import Foundation

struct People {

    enum Gender: Int {
        case male
        case female
        case other
    }

    let firstname: String
    let lastname: String

    let movies: [String]
    let bio: String // not in SWAPI

    let alive: Bool // not in SWAPI

    let gender: Gender

    let birthdate: Int

    let nickname: String? // not in SWAPI

    static var all: [People] {
        return [People(firstname: "Luke", lastname: "Skywalker", movies: ["1", "2", "3", "4", "5", "6"], bio: "Fils d'Anakin", alive: true, gender: .male, birthdate: 1965, nickname: nil)]
    }
}
