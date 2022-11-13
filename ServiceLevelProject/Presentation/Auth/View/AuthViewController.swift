
//
// AuthViewController.swift
// ServiceLevelProject
//
// Created by useok on 2022/11/08.
//

import UIKit
import FirebaseAuth

class AuthViewController: BaseViewController {
    
    let authView = AuthView()
    
    var verifyID: String?
    
    
    
    override func loadView() {
        super.view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.authButton.addTarget(self, action: #selector(authVerifyCode), for: .touchUpInside)
        
    }
    @objc func authVerifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: authView.authTextField.text ?? "")
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print("succeess:",success)
                
                // idtoken
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    
                    
                    if let error = error {
                        // Handle error
                        return;
                    }
                    print("idToken",idToken)
                    UserInfo.shared.fcmtoken = idToken 
                    UserDefaults.standard.set(idToken, forKey: "token")
                }
                
                let vc = NickNameViewController()
                self.transition(vc, transitionStyle: .push)
            } else {
                print("error:",error)
            }
        }
        
        
    }
    
    
    
    
}


