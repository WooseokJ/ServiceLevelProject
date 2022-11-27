//
//  APIProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import UIKit
import FirebaseAuth
import Toast

 

protocol APIProtocol {
    func presentVC()
    func refreshIdToken()
}

extension APIProtocol where Self: UIViewController { // where Self로 VC받아서 VC에있는 view, 여러 버튼등등 쓸수있는데
    // 이러면 여기서 예를들어
    var apiQueue: APIQueue {
        return APIQueue()
    }
    var homeView: HomeView {
        return HomeView()
    }
    
    func refreshIdToken()  {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                self.view.makeToast("토큰 갱신 에러")
                return;
            }
            print("갱신한 idToken",idToken)
            UserDefaults.standard.set(idToken!, forKey: "token")
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


