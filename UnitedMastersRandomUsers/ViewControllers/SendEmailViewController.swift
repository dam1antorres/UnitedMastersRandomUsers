//
//  SendEmailViewController.swift
//  UnitedMastersRandomUsers
//
//  Created by Damian Torres on 10/18/22.
//

import Combine
import Foundation
import MessageUI
import UIKit

class SendEmailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    private let presenter: EmailPresenter
    private var cancellables = Set<AnyCancellable>()

    init(presenter: EmailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sendEmail(presenter.email)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func sendEmail(_ email: String) {
        let subject = "This is supposed to send a email"
        let body = "This code supports sending email via multiple different email apps on iOS! :)"

        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)

            present(mail, animated: true)

            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(to: email, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }

    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }

        return defaultUrl
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        presenter.dismissEmail()
    }
}
