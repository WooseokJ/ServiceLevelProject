//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit

final class APIUser {
    typealias completionHandler = ( (Int, Bool) -> Void )
    
    init() {}
    
    /// 회원가입
    func signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String, email: String, gender: Int, completionHandler: @escaping completionHandler ) {
        let api = APIHeader.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate()
            .responseString { [self] response in
                
                switch response.result {
                case .success(let data):
                    completionHandler(response.response!.statusCode, true )
                case .failure(let error):
                    print("fail: \(error)")
                }
            }
           
    }
    
    
    /// 로그인
    func login(completionHandler: @escaping completionHandler) {
        let api = APIHeader.login
        AF.request(api.url,method: api.method, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result {
            case .success(let data):
                completionHandler(response.response!.statusCode, true )
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
    
    func withdraw(completionHandler: @escaping completionHandler) {
        let api = APIHeader.withdraw
        AF.request(api.url,method: api.method, headers: api.headers).validate().response { response in
            switch response.result {
            case .success(let data):
                completionHandler(response.response!.statusCode, true )
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
}
