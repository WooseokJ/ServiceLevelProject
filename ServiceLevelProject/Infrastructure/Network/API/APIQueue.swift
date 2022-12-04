//
//  APIQueue.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import Foundation
import Alamofire

final class APIQueue {
    
    typealias QueuPostHandler = ( (Result<Data?, queuePostErorr>) -> Void )
    typealias QueuStopHandler = ( (Result<Data?, queueStopError>) -> Void )
    typealias SearchInfoHandler = ( (Result<Search?, searchPostError>) -> Void )
    typealias MyQueueStateHandler = ( (Result<MyQueueState?, myQueueStateErorr>) -> Void )
    typealias StudyPostRequestHandler = ( (Result<Data?, studyRequestError>) -> Void )
    typealias StudyPostAcceptHandler = ( (Result<Void?, studyAcceptError>) -> Void )
    typealias StudyPostDodgeHandler = ( (Result<Data?, studyDodgeError>) -> Void )

    init() {}
    
    
    ///스터디 함께할 새싹 찾기 요청
    func queueRequest(lat: Double, long: Double, studylist: [String], completionHandler: @escaping QueuPostHandler ) {
        let api = APIHeader.queue(lat: lat, long: long, studylist: studylist)
        AF.request(api.url, method: api.method, parameters: api.parameters , encoding: URLEncoding(arrayEncoding: .noBrackets), headers: api.headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure :
                guard let customError = queuePostErorr(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(queuePostErorr(rawValue: customError.rawValue)!))
            }
        }
    }
    
    /// 스터디를 함께할 새싹 찾기 중단
    func searchStopRequest(completionHandler: @escaping QueuStopHandler) {
        let api = APIHeader.searchStop
        AF.request(api.url, method: .delete, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result{
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = queueStopError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(queueStopError(rawValue: customError.rawValue)!))
            }
        }
    }
    
    /// 스터디를 함께할 새싹 검색
    func searchRequest(lat: Double, long: Double, completionHandler: @escaping SearchInfoHandler) {

        let api = APIHeader.search(lat: lat, long: long)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = searchPostError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(searchPostError(rawValue: customError.rawValue)!))
            }
        }
    }
    
    
    /// 서용자의 매칭상태 확인
    func myqueueStateRequest(completionHandler: @escaping MyQueueStateHandler) {
        
        let api = APIHeader.myQueueState
        AF.request(api.url, method: api.method, headers: api.headers).validate().responseDecodable(of: MyQueueState.self) { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = myQueueStateErorr(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(myQueueStateErorr(rawValue: customError.rawValue)!))
            }
        }
    }
    
    /// 스터디요청
    func studyPostRequest(otheruid: String, completionHandler: @escaping StudyPostRequestHandler) {
        let api = APIHeader.studyPost(otheruid: otheruid)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result {
                
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = studyRequestError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(studyRequestError(rawValue: customError.rawValue)!))
            }
        }
    }
    /// 스터디 수락
    func studyPostAccept(otheruid: String,  completionHandler: @escaping StudyPostAcceptHandler) {
        let api = APIHeader.studyAccept(otheruid: otheruid)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate(statusCode: 200..<201).response { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(()))
            case .failure:
                guard let customError = studyAcceptError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(studyAcceptError(rawValue: customError.rawValue)!))
            }
        }
    }
    
    /// 스터디취소
    func studyPostDodge(otheruid: String,  completionHandler: @escaping StudyPostDodgeHandler) {
        let api = APIHeader.studyDodge(otheruid: otheruid)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = studyDodgeError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(studyDodgeError(rawValue: customError.rawValue)!))
            }
        }
    }
    
    
    
    
}
