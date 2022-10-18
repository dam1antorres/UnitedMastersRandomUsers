//
//  DetailPresenter.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Combine
import Foundation

class DetailPresenter {

    private let interactor: DetailInteractor
    private let router: Router
    @Published var cardConfig: CardConfig

    init(router: Router, interactor: DetailInteractor) {
        self.interactor = interactor
        self.router = router
        self.cardConfig = CardConfig(firstAndLastName: interactor.firstAndLastName,
                                             email: interactor.email,
                                             profilePictureURL: interactor.profilePictureURL)
    }

    func presentEmail() {
        router.handleSegue(.detailSegue(.showEmail(email: interactor.email)))
    }

}
