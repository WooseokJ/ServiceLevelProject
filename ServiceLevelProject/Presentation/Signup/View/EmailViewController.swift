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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.phoneNumberTextField.becomeFirstResponder()
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
        
        UserDefaults.standard.set(loginView.phoneNumberTextField.text, forKey: "email")
        guard loginView.phoneNumberTextField.text?.contains("@") == true else {
            self.view.makeToast("@를 붙여주세요")
            return
        }
        guard loginView.phoneNumberTextField.text?.contains(".com") == true else {
            self.view.makeToast(".com을 붙여주세요")
            return
        }
        let vc =  GenderViewController()
        transition(vc, transitionStyle: .push)
    }
}

extension EmailViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginView.phoneNumberTextField.resignFirstResponder()
        guard loginView.phoneNumberTextField.text!.isEmpty else {
            loginView.phoneButton.backgroundColor = BrandColor.green
            return true
        }
        loginView.phoneButton.backgroundColor = .lightGray
        return true
    }

}
