//
//  WithdrawProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/04.
//

import UIKit


protocol WithdrawProtocol: APIProtocol {
    var apiUser: APIUser {get}
    
}

extension WithdrawProtocol where Self: InfoManageMentViewController {
    var apiUser: APIUser {
        return APIUser()
    }
    
    
    func withdraw() {
        apiUser.withdraw { [weak self] data in
            do {
                switch data {
                case .success:
                    
                    for key in UserDefaults.standard.dictionaryRepresentation().keys {
                        if key == "fcmtoken" {
                            continue
                        }
                        UserDefaults.standard.removeObject(forKey: key.description)
                    }
                    
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = OnBoardingViewController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.withdraw()
                    }
                case .failure(.withdrawUserError):
                    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                    let sceneDelegate = windowScene?.delegate as? SceneDelegate
                    let vc = OnBoardingViewController()
                    sceneDelegate?.window?.rootViewController = vc
                    sceneDelegate?.window?.makeKeyAndVisible()
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
    
  
    

}


