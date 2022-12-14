//
//  SignupViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

class NickNameViewController: BaseViewController {

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
        loginView.phoneButton.addTarget(self, action: #selector(nicknameClicked), for: .touchUpInside)
        
    }
    
    
    func newText() {
        loginView.phoneNumberTextField.placeholder = "10자 이내로 입력"
        loginView.phoneTextLabel.text = "닉네임을 입력해 주세요"
        loginView.phoneButton.setTitle("다음", for: .normal)
    }
    
    
    @objc func nicknameClicked() {
        guard ((loginView.phoneNumberTextField.text?.contains("고래밥")) != true) else {return}
        guard ((loginView.phoneNumberTextField.text?.contains("미묘한도사")) != true) else {return}
        guard ((loginView.phoneNumberTextField.text?.contains("바람의나라")) != true) else {return}
        guard ((loginView.phoneNumberTextField.text?.contains("휴저씨")) != true) else {return}
        guard ((loginView.phoneNumberTextField.text?.contains("아저씨")) != true) else {return}
        UserDefaults.standard.set(loginView.phoneNumberTextField.text, forKey: "nick")
        let vc = BirthViewController()
        transition(vc, transitionStyle: .push)
    }
    

  
}

extension NickNameViewController: UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.count < 10 {
            print(textField.text?.count)
        }
    }
}
