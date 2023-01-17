//
//  APIProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import UIKit
import FirebaseAuth
import Toast

@objc protocol APIProtocol {
    @objc optional func presentVC()
    @objc optional func refreshIdToken()
}

extension APIProtocol where Self: UIViewController {
    
    typealias completion = ( () -> Void)
    
    func refreshIdToken(completion: @escaping completion) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if error != nil {
                self.view.makeToast("토큰 갱신 에러")
                return;
            }
            print("갱신한 idToken",idToken as Any)
            UserDefaults.standard.set(idToken!, forKey: "token")
            completion() 
        }
    }
    func presentVC() {
         let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
         let sceneDelegate = windowScene?.delegate as? SceneDelegate
         let vc = NickNameViewController()
         let nav = UINavigationController(rootViewController: vc)
         sceneDelegate?.window?.rootViewController = nav
         sceneDelegate?.window?.makeKeyAndVisible()
     }

    
}



//extension BaseViewController: APIProtocol {
//    func presentVC() {
//         let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//         let sceneDelegate = windowScene?.delegate as? SceneDelegate
//         let vc = NickNameViewController()
//         let nav = UINavigationController(rootViewController: vc)
//         sceneDelegate?.window?.rootViewController = nav
//         sceneDelegate?.window?.makeKeyAndVisible()
//     }
//}
