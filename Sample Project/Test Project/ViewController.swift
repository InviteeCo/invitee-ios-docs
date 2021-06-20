//
//  ViewController.swift
//  Test Project
//
//  Created by Luke Langford on 15/5/21.
//

import UIKit
import Invitee

class ViewController: UIViewController {
    
    private let user = User(customerId: "abcd-1234-abcd-1234", firstName: "John", lastName: "Appleseed", phoneNumber: "0412345678")
    
    private lazy var referButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        layoutUI()
        bindControls()
        setupUserInCampaign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        InviteeClient.shared.presentNotificationIfNeeded()
    }
    
    private func layoutUI() {
        view.addSubview(referButton)
        referButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
    }
    
    private func bindControls() {
        referButton.addTapGesture { [weak self] in
            guard let weakself = self else { return }
            InviteeClient.shared.present(on: weakself)
        }
    }
    
    private func setupUserInCampaign() {
        InviteeClient.shared.setup(for: user) { [weak self] maybeCampaign in
            guard let weakself = self, let campaign = maybeCampaign else {
                self?.referButton.isHidden = false
                return
            }

            weakself.referButton.setTitle(campaign.title, for: .normal)
            weakself.referButton.isHidden = false
        }
    }

}

