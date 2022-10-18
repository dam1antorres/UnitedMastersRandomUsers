//
//  Segues.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/18/22.
//

import Foundation

enum Segues {
    case detailSegue(DetailSegue)
}

enum DetailSegue {
    case showDetails(User)
    case showEmail(email: String)
    case dismissEmail
}
