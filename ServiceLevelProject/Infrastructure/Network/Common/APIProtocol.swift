//
//  APIProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import UIKit
import FirebaseAuth

@objc protocol APIProtocol { //  선택적함수 사용가능 
    @objc optional func presentVC() // 선택적 함수
    @objc optional func refreshIdToken() // 선택적 함수
}

extension APIProtocol {
    func refreshIdToken() { //그렇게되면 로그인,회원가입,탈퇴,서치 등 다 만들어야하나?
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                // Handle error
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
