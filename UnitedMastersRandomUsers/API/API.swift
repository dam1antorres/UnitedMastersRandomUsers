//
//  API.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Foundation

class API {

    enum APIError: LocalizedError {
        case invalidUrl
        case unknownError
    }

    struct Constants {
        static let host = "https://randomuser.me/api?results=40"
    }

    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func fetchRandomUsers() async throws -> [User] {
        guard let url = URL(string: Constants.host) else {
            throw APIError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        let status = (response as? HTTPURLResponse)?.statusCode

        if let status = status, (200..<300).contains(status) {
            let users = try decoder.decode(UserList.self, from: data)
            return users.results
        } else {
            throw APIError.unknownError
        }
    }

}
