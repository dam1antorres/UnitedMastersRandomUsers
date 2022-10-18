//
//  ListInteractor.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Combine
import Foundation

class ListInteractor {
    let api = API()

    @Published var users: [User] = []
    @Published var fetchError: Error?

    init() {
        fetchUsers()
    }

    func fetchUsers() {
        Task {
            do {
                let users = try await api.fetchRandomUsers()
                self.users = users
            } catch {
                fetchError = error
            }
        }
    }

    func firstNameFor(_ index: Int) -> String {
        users[index].name.first
    }

}
