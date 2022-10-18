//
//  DetailInteractor.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Foundation

class DetailInteractor {

    private let user: User

    init(user: User) {
        self.user = user
    }

    var firstAndLastName: String {
        "\(user.name.first) \(user.name.last)"
    }

    var profilePictureURL: URL {
        user.picture.medium
    }

    var email: String {
        user.email
    }
}
