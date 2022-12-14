//
//  SignupProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/04.
//

import UIKit

protocol SignupProtocol: APIProtocol {
    var apiUser: APIUser {get}
    
}

extension SignupProtocol where Self: GenderViewController {
    var apiUser: APIUser {
        return APIUser()
    }
    
    
    func signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int) {
        apiUser.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender) { [weak self] data in
            do {
                switch data {
                case .success:
                    UserDefaults.standard.set(true,forKey: "first") 
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = TapViewController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                
                case .failure(.regUserError):
                    self?.view.makeToast("이미 가입한 유저")
//                    let viewControllers : [UIViewController] = self?.navigationController!.viewControllers as [UIViewController]
//                    self?.navigationController?.popToViewController(viewControllers[0], animated: true)
                    
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                    
                case .failure(.notNickNameError):
                    self?.view.makeToast("사용할수 없는 닉네임")
                    
                }
            }
            catch {
                print("에러야")
                return
            }
        }

    }
    

}


