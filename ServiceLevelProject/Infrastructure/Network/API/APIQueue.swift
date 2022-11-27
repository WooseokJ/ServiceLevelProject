//
//  APIQueue.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import Foundation
import Alamofire

final class APIQueue {
    
    typealias completionHandler = ( (Result<Data, CommonError>) -> Void )
    typealias SearchInfo = ((Int, Search?) -> Void)
    typealias MyQueueStateInfo = ((Int, MyQueueState?) -> Void)
    
    init() {}
    
    
    ///스터디 함께할 새싹 찾기 요청
    func queueRequest(lat: Double, long: Double, studylist: [String], completionHandler: @escaping completionHandler ) {
        let api = APIHeader.queue(lat: lat, long: long, studylist: studylist)
        AF.request(api.url, method: api.method, parameters: api.parameters , encoding: URLEncoding(arrayEncoding: .noBrackets)).validate().responseData { response in //, headers: api.headers
            switch response.result {
            case .success(let data): // 이렇게하면되나
                completionHandler(.success(data)) //
            case .failure :
                guard let customError = CommonError(rawValue: response.response!.statusCode) else{
                    print("여깈타")
                    return
                }
                completionHandler(.failure(CommonError(rawValue: customError.rawValue)!))
//                print(customError)
//                print("dddd",ttt.responseCode)
//                print("dddddss")
            }
        }
    }
    
    /// 스터디를 함께할 새싹 찾기 중단
    func searchStopRequest(idtoken: String, completionHandler: @escaping completionHandler) {
        let api = APIHeader.searchStop
        AF.request(api.url, method: .delete, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result{
            case .success(let data) :
                completionHandler(.success(data!)) //

//                completionHandler(response.response!.statusCode, true)
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
    
    /// 스터디를 함께할 새싹 검색
    func searchRequest(lat: Double, long: Double, completionHandler: @escaping SearchInfo) {

        let api = APIHeader.search(lat: lat, long: long)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(response.response!.statusCode, data)
            case .failure(let error):
                print("fail: \(error)")
            }
        }
    }
    
    
    /// 서용자의 매칭상태 확인
    func myqueueStateRequest(completionHandler: @escaping MyQueueStateInfo) {
        
        let api = APIHeader.myQueueState
        AF.request(api.url, method: api.method, headers: api.headers).validate().responseDecodable(of: MyQueueState.self) { response in
            switch response.result{
            case .success(let data): //
                completionHandler(response.response!.statusCode, data)
            case .failure(let error):
                completionHandler(response.response!.statusCode, nil)
            }
        }
    }
    
}
