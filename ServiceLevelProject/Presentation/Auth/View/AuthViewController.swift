
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

class AuthViewController: BaseViewController, APIProtocol, LoginProtocol{
    
    let authView = AuthView()
    var verifyID: String?
    var apiUser = APIUser()
    
    override func loadView() {
        super.view = authView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authView.authTextField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        self.view.makeToast("인증번호를 보냈습니다.")
    }
    private func bind() {
        authView.authButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.signIn()
                vc.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        authView.authTextField.rx.text
            .withUnretained(self)
            .bind { (vc,val) in
                if val?.count ?? 0 >= 6 {
                    vc.authView.authButton.backgroundColor = BrandColor.green
                } else {
                    vc.authView.authButton.backgroundColor = Grayscale.gray6
                }
                
            }
            .disposed(by: disposeBag)
        authView.authredirectButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                PhoneAuthProvider.provider().verifyPhoneNumber("+82" + (UserDefaults.standard.string(forKey: "phoneNumber") ?? ""), uiDelegate: nil) { (varification,error) in
                    if error == nil {
                        self.verifyID = varification
                        vc.view.endEditing(true)
                        self.view.makeToast("인증번호 재전송")
                    } else {
                        vc.view.endEditing(true)
                        self.view.makeToast("인증번호 과도한 요청")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func signIn() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: authView.authTextField.text ?? "")
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                print("succeess:",success)
                self.login()
            } else {
                self.view.endEditing(true)
                self.view.makeToast("전화 번호 인증 실패")
                
            }
        }
    }

    
    
    
//    func getIdToken() {
//        // idtoken
//        let currentUser = Auth.auth().currentUser
//        currentUser?.getIDToken(completion: { idToken, error in
//            if let error = error {
//                // Handle error
//                return
//            }
//            print("idToken",idToken)
//
//            self.apiUser.login() { data in
//                if val && statusCode == 200 {
//                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
//                    let vc = TapViewController()
//                    sceneDelegate?.window?.rootViewController = vc
//                    sceneDelegate?.window?.makeKeyAndVisible()
//                } else {
//                    switch statusCode {
//                    case 401: self.view.makeToast("전화 번호 인증 실패")
//                    case 406:
//                        let vc = NickNameViewController()
//                        self.transition(vc, transitionStyle: .push)
//                    case 500:
//                        self.view.makeToast("전화 번호 인증 실패")
//                    case 501:
//                        self.view.makeToast("전화 번호 인증 실패")
//                    default:
//                        self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
//                    }
//                }
//            }
//            }
//        })
//    }
}
                                
