//
//  EmailPresenter.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/18/22.
//

import Foundation

class EmailPresenter {

    private let interactor: EmailInteractor
    private let router: Router

    var email: String {
        interactor.email
    }

    init(router: Router, interactor: EmailInteractor) {
        self.interactor = interactor
        self.router = router
    }

    func dismissEmail() {
        router.handleSegue(.detailSegue(.dismissEmail))
    }
}
