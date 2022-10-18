//
//  Router.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Foundation
import UIKit

class Router {

    private var contentViewController: UIViewController?
    private var mainNavigationController: UINavigationController? {
        return contentViewController as? UINavigationController
    }

    func launch(in window: UIWindow) {
        let interactor = ListInteractor()
        let presenter = ListPresenter(router: self, interactor: interactor)
        contentViewController = UINavigationController(rootViewController: RandomUsersViewController(presenter: presenter))
        window.rootViewController = contentViewController
    }

    func handleSegue(_ segue: Segues) {
        switch segue {
        case .detailSegue(let segue):
            handleDetailSegue(segue)
        }
    }

    private func handleDetailSegue(_ segue: DetailSegue) {
        switch segue {
        case .showDetails(let user):
            presentDetailScreen(user: user)
        case .showEmail(let email):
            presentEmail(email: email)
        case .dismissEmail:
            contentViewController?.dismiss(animated: true)
        }
    }

    private func presentDetailScreen(user: User) {
        let interactor = DetailInteractor(user: user)
        let presenter = DetailPresenter(router: self, interactor: interactor)
        let viewController = RandomUserDetailViewController(presenter: presenter)
        contentViewController?.modalPresentationStyle = .fullScreen
        contentViewController?.present(viewController, animated: true)
    }

    private func presentEmail(email: String) {
        contentViewController?.dismiss(animated: true) {
            let interactor = EmailInteractor(email: email)
            let presenter = EmailPresenter(router: self, interactor: interactor)
            let sendEmailViewController = SendEmailViewController(presenter: presenter)
            self.contentViewController?.modalPresentationStyle = .fullScreen
            self.contentViewController?.present(sendEmailViewController, animated: true)
        }
    }
}
