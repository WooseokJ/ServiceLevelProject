//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit

final class APIUser {
    
    typealias mypageHandler = ( ((Result<MypageInfo,myPageError>) -> Void ))
    typealias signupHandler = ( (Result<String?, SingupError>) -> Void )
    typealias loginHandler = ( (Result<LoginInfo?, loginError>) -> Void )
    typealias withdrawHandler = ( (Result<Data?, withdrawError>) -> Void )
    
    init() {}
    
    /// 회원가입
    func signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int, completionHandler: @escaping signupHandler ) {
        let api = APIHeader.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure :
                    guard let customError = SingupError(rawValue: response.response!.statusCode) else{return}
                    completionHandler(.failure(SingupError(rawValue: customError.rawValue)!))
                }
            }
    }
    
    
    /// 로그인
    func login(completionHandler: @escaping loginHandler) {
        let api = APIHeader.login
        AF.request(api.url,method: api.method, parameters: api.parameters, headers: api.headers).validate().responseDecodable(of: LoginInfo.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure :
                guard let customError = loginError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(loginError(rawValue: customError.rawValue)!))
            }
        }
    }
    /// 회원탈퇴
    func withdraw(completionHandler: @escaping withdrawHandler) {
        let api = APIHeader.withdraw
        AF.request(api.url,method: api.method, headers: api.headers).validate().response { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure :
                guard let customError = withdrawError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(withdrawError(rawValue: customError.rawValue)!))
            }
        }
    }
    /// 마이페이지
    func myPageUpdate(completionHandler: @escaping mypageHandler) {
        let api = APIHeader.mypage
        AF.request(api.url,method: api.method, headers: api.headers).validate().responseDecodable(of: MypageInfo.self)  { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure :
                guard let customError = myPageError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(myPageError(rawValue: customError.rawValue)!))
            }
        }
    }
    
}
