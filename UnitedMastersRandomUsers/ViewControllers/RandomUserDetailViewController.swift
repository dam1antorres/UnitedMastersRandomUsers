//
//  RandomUserDetailViewController.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Combine
import Foundation
import SnapKit
import UIKit

class RandomUserDetailViewController: UIViewController {

    private let presenter: DetailPresenter
    private let cardView = UserDetailCardView()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
        view.backgroundColor = .white
    }

    init(presenter: DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        view.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func setupBindings() {
        presenter.$cardConfig
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] config in
                self?.updateUI(config)
            })
            .store(in: &cancellables)

        cardView.$emailTapped
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.presenter.presentEmail()
            })
            .store(in: &cancellables)
    }

    private func updateUI(_ config: CardConfig) {
        cardView.config = config
    }
    
}
