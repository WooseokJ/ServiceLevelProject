//
//  EmailViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class EmailViewController: BaseViewController {

    let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText()
        loginView.phoneButton.addTarget(self, action: #selector(emailButtonClicked), for: .touchUpInside)
        
    }
    

    func newText() {
        loginView.phoneNumberTextField.placeholder = "SeSAC@email.com"
        loginView.phoneTextLabel.text = "이메일을 입력해 주세요"
        loginView.phoneButton.setTitle("다음", for: .normal)


    }
    
    
    @objc func emailButtonClicked() {
        UserInfo.shared.email = loginView.phoneNumberTextField.text
        let vc =  GenderViewController()
        transition(vc, transitionStyle: .push)
    }
}
