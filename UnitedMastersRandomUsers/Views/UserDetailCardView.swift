//
//  UserDetailCardView.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/17/22.
//

import Combine
import Foundation
import Kingfisher
import SnapKit
import UIKit

class UserDetailCardView: UIView {

    @Published var emailTapped: Void = ()

    var config: CardConfig? {
        didSet {
            updateUI()
        }
    }

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        return label
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    private let profilePicture = UIImageView()
    private let cardContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        cardContainer.layer.borderColor = UIColor.lightGray.cgColor
        cardContainer.layer.borderWidth = 2.0
        cardContainer.layer.cornerRadius = 5.0
        cardContainer.layer.masksToBounds = true

        profilePicture.layer.cornerRadius = 5.0
        profilePicture.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(cardContainer)
        cardContainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.0)
            make.right.equalToSuperview().offset(-15.0)
            make.height.equalTo(200.0)
        }

        cardContainer.addSubview(profilePicture)
        profilePicture.snp.makeConstraints { make in
            make.centerY.equalTo(cardContainer.snp.centerY)
            make.left.equalToSuperview().offset(15.0)
        }
        cardContainer.addSubview(infoStack)
        infoStack.snp.makeConstraints { make in
            make.left.equalTo(profilePicture.snp.right).offset(15.0)
            make.top.equalTo(profilePicture.snp.top)
            make.bottom.equalTo(profilePicture.snp.bottom)
            make.right.lessThanOrEqualToSuperview()
        }
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        [nameLabel, button].forEach { infoStack.addArrangedSubview($0) }
    }

    private func updateUI() {
        guard let config = config else { return }
        profilePicture.kf.setImage(with: config.profilePictureURL)
        nameLabel.text = config.firstAndLastName
        button.setTitle(config.email, for: .normal)
    }

    @objc func buttonTapped() {
        emailTapped = ()
    }
    
}
