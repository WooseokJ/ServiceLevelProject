//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit
import Toast
import FirebaseAuth

struct Profile: Codable {
    let user: User
}
struct User: Codable {
    let phoneNumber: String
    let FCMtoken: String
    let nick: String
    let birth: String
    let email: String
    let gender: Int
}



final class APIService {
    //MARK: - 싱글턴 변수
    
    typealias completionHandler = ( (Bool, Int) -> Void )
    typealias ProfileInfo = ((Profile?) -> Void )
    
    init() {}
    
    
    /// 회원가입
    func signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String,
                email: String, gender: Int, completionHandler: @escaping completionHandler ) {
        let api = API.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender)
        
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseString(completionHandler: { response in
            print("signup, response:",response)
            print("회원가입 상태코드",response.response?.statusCode)
                
            switch response.response?.statusCode {
            case 200:
                completionHandler(true,response.response!.statusCode)
            case 201:
                completionHandler(false,response.response!.statusCode)
            case 202:
                completionHandler(false,response.response!.statusCode)
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = NickNameViewController()
                let nav = UINavigationController(rootViewController: vc)
                sceneDelegate?.window?.rootViewController = nav
                sceneDelegate?.window?.makeKeyAndVisible()
            case 401: 
                // idtoken
                let currentUser = Auth.auth().currentUser
                currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                    if let error = error {
                        // Handle error
                        return;
                    }
                    print("갱신한 idToken",idToken)
                    UserDefaults.standard.set(idToken!, forKey: "token")
                }
                completionHandler(false,response.response!.statusCode)
            case 500:
                completionHandler(false,response.response!.statusCode)
            case 501:
                completionHandler(false,response.response!.statusCode)
            default:
                completionHandler(false,response.response!.statusCode)
            }
        }
        )
    }
    
//    ///로그인
    func login(idtoken: String, completionHandler: @escaping completionHandler  ) {
        let api = API.login(idtoken: idtoken)
        
        AF.request(api.url,method: .get, parameters: api.parameters, headers: api.headers).validate().response { response in
            print("상태코드: ",response.response?.statusCode)
                switch response.response?.statusCode {
                case 200:
                    completionHandler(true,response.response!.statusCode)
                case 401:
                    print("토큰만료")
                    completionHandler(false,response.response!.statusCode)
                case 406:
                    print("406")
                    completionHandler(false,response.response!.statusCode)
                case 500:
                    print("서버에러")
                    completionHandler(false,response.response!.statusCode)
                case 501:
                    print("클라이언트 오류")
                    completionHandler(false,response.response!.statusCode)
                default:
                    print("error")
                    completionHandler(false,response.response!.statusCode)
                }
                
            }
    }
//    /// 프로필보기
//    func profile(completionHandler: @escaping ProfileInfo) {
//        let api = API.profile
//        AF.request(api.url,method: .get, headers: api.headers)
//            .responseDecodable(of: Profile.self) { response in
//                switch response.result {
//                case.success(let data) :
//                    completionHandler(data)
//                case .failure(let error) :
//                    print("profile fail: \(error)")
//                }
//            }
//    }
}

