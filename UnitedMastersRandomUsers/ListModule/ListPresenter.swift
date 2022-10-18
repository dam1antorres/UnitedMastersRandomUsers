//
//  ListPresenter.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Combine
import Foundation

class ListPresenter {

    private let interactor: ListInteractor
    private let router: Router
    private var cancellables = Set<AnyCancellable>()

    @Published var users: [User] = []

    init(router: Router, interactor: ListInteractor) {
        self.interactor = interactor
        self.router = router
        setupBindings()
    }

    private func setupBindings() {
        interactor.$users
            .assign(to: \.users, on: self)
            .store(in: &cancellables)
    }

    func firstNameFor(_ index: Int) -> String {
        interactor.firstNameFor(index)
    }

    func presentUserDetails(_ index: Int) {
        router.handleSegue(.detailSegue(.showDetails(users[index])))
    }

}
