//
//  LoginProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/04.
//

import UIKit

protocol LoginProtocol {
    var apiUser: APIUser {get}
    
}

extension LoginProtocol where Self: AuthViewController {
    var apiUser: APIUser {
        return APIUser()
    }
    
    func login() {
        apiUser.login { [weak self] data in
            do {
                switch data {
                case .success:
                    print("로그인 성공")
                    UserDefaults.standard.set(true, forKey: "first")
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = TapViewController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.login()
                    }
                case .failure(.notUserError):
                    let nickVC = NickNameViewController()
                    self?.transition(nickVC, transitionStyle: .push)
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch {
                print("에러야")
                return
            }
        }
    }
    
    
//    func signup() {
//        apiUser.signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int) { [weak self] data in
//            do {
//                switch data {
//                case .success:
//
//                case .failure(.tokenErorr):
//                    self?.refreshIdToken {
//                        self?.signup()
//                    }
//                case .failure(.notUserError):
//
//                case .failure(.serverError):
//                    self?.view.makeToast("서버 에러")
//                case .failure(.clientError):
//                    self?.view.makeToast("클라이언트 에러")
//                }
//            }
//            catch {
//                print("에러야")
//                return
//            }
//        }
//        
//    }
    

}


