
//
// AuthViewController.swift
// ServiceLevelProject
//
// Created by useok on 2022/11/08.
//

import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class AuthViewController: BaseViewController {
    
    let authView = AuthView()
    
    var verifyID: String?
    

    
    override func loadView() {
        super.view = authView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authView.authTextField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        authView.authButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: vc.verifyID ?? "", verificationCode: vc.authView.authTextField.text ?? "")
                
                Auth.auth().signIn(with: credential) { success, error in
                    if error == nil {
                        print("succeess:",success)
                        self.getIdToken()
                    } else { print("error:",error)}
                }
            }
            .disposed(by: disposeBag)
        authView.authTextField.rx.text
        self.view.makeToast("인증번호를 보냈습니다.")
    }
    
    
    func getIdToken() {
        // idtoken
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDToken(completion: { idToken, error in
            if let error = error {
                // Handle error
                
                return
            }
            print("idToken",idToken)
            UserInfo.shared.fcmtoken = UserDefaults.standard.string(forKey: "fcmtoken")
            UserDefaults.standard.set(idToken!, forKey: "token")
            
            self.api.login(idtoken: idToken!) { val, statusCode in
                print(statusCode,val)
                if val && statusCode == 200 {
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = TapViewController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                } else {
                    switch statusCode {
                    case 401: self.view.makeToast("전화 번호 인증 실패")
                    case 406:
                        let vc = NickNameViewController()
                        self.transition(vc, transitionStyle: .push)
                    case 500:
                        self.view.makeToast("전화 번호 인증 실패")
                    case 501:
                        self.view.makeToast("전화 번호 인증 실패")
                    default:
                        self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
                    }
         
                }
            }
        })
    }
}

