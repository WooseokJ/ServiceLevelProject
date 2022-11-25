//
//  APIService.swift
//  SesackWeek18
//
//  Created by useok on 2022/11/02.
//


import Alamofire
import UIKit
import FirebaseAuth


final class APIUser: APIProtocol {
    
    //MARK: - 싱글턴 변수
    typealias completionHandler = ( (Bool, Int) -> Void )
    typealias ProfileInfo = ((Profile?) -> Void )
    
    init() {}
    
    /// 회원가입
    func signup(phoneNumber: String, FCMtoken: String, nick: String, birth: String,
                email: String, gender: Int, completionHandler: @escaping completionHandler ) {
        let api = APIHeader.signup(phoneNumber: phoneNumber, FCMtoken: FCMtoken, nick: nick, birth: birth, email: email, gender: gender)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers)
            .validate()
            .responseString(completionHandler: { [self] response in
                switch response.response?.statusCode {
                case CommonError.success.rawValue: completionHandler(true,response.response!.statusCode)
                case SingupError.regUserError.rawValue: completionHandler(false,response.response!.statusCode)
                case SingupError.notNickNameError.rawValue: //202
                    completionHandler(false,response.response!.statusCode)
                    presentVC()
                case CommonError.tokenErorr.rawValue: //401
                    DispatchQueue.main.async {
                        refreshIdToken()
                    }
                    completionHandler(false,response.response!.statusCode)
                case CommonError.serverError.rawValue: completionHandler(false,response.response!.statusCode)
                case CommonError.clientError.rawValue: completionHandler(false,response.response!.statusCode)
                default: completionHandler(false,response.response!.statusCode)
                }
            }
            )
    }
    
    /// 로그인
    func login(idtoken: String, completionHandler: @escaping completionHandler  ) {
        let api = APIHeader.login(idtoken: idtoken)
        //        idtokenRefresh()
        AF.request(api.url,method: api.method, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.response?.statusCode {
            case CommonError.success.rawValue: completionHandler(true,response.response!.statusCode)
            case CommonError.tokenErorr.rawValue: completionHandler(false,response.response!.statusCode)
            case CommonError.notUserError.rawValue: completionHandler(false,response.response!.statusCode)
            case CommonError.serverError.rawValue: completionHandler(false,response.response!.statusCode)
            case CommonError.clientError.rawValue: completionHandler(false,response.response!.statusCode)
            default: completionHandler(false,response.response!.statusCode)
            }
            
        }
    }
    /// 프로필보기
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
