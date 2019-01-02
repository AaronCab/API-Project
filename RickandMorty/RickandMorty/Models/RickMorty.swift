//
//  RickMorty.swift
//  RickandMorty
//
//  Created by Aaron Cabreja on 1/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct CharacterData: Codable {
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
}

struct Origin: Codable {
    let name: String
}

struct Location: Codable {
    let name: String
}

