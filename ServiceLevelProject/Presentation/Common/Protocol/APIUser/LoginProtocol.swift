//
//  LoginProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/04.
//

import UIKit

protocol LoginProtocol: APIUserProtocol, APIProtocol {
//    func login()
}



extension LoginProtocol where Self: AuthViewController {
    
    
    func login() {
        apiUser.login { [weak self] data in
            do {
                switch data {
                case .success:
                    print("로그인 성공")
                    UserDefaults.standard.set(try data.get().value?.uid!, forKey: "Myuid")
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
}
extension LoginProtocol where Self: MyInfoViewController {
    func login(completionHandler: @escaping ((LoginInfo?) -> Void) ) {
        apiUser.login { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    completionHandler(try data.get().value!)
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.login() { _ in
                            self?.view.makeToast("토큰 갱신후 재시도")
                        }
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
}

