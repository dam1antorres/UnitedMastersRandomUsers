//
//  User.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Foundation

struct UserList: Decodable {
    let results: [User]
}

struct User: Decodable {
    let name: Name
    let email: String
    let picture: Picture
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: URL
    let medium: URL
    let thumbnail: URL
}
