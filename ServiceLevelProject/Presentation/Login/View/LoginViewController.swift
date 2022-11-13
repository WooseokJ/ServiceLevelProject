//
//  LoginViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/08.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {

    var loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    private var verifyID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.phoneButton.addTarget(self, action: #selector(requestVerifyCode), for: .touchUpInside)
        
        
        
    }
    
    @objc func requestVerifyCode() {

        PhoneAuthProvider.provider().verifyPhoneNumber(loginView.phoneNumberTextField.text ?? "", uiDelegate: nil) { [self] (varification,error) in
            if error == nil {
                self.verifyID = varification
                print("verify:",verifyID)
                
                UserInfo.shared.phoneNumber = loginView.phoneNumberTextField.text // 폰번호입력
                
                let vc = AuthViewController()
                vc.verifyID = varification
                self.transition(vc, transitionStyle: .push) 
            } else {
                print("error",error)
                print("넌 오류야 ")
            }
        }
      }
        
    

}
