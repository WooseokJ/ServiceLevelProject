//
//  APIQueue.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/25.
//

import Foundation
import Alamofire
import FirebaseAuth

struct CustomGetEncoding : ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}
 

final class APIQueue {
    var apiProtocol: APIProtocol?
    
    typealias completionHandler = ( (Bool, Int) -> Void )
    typealias SearchInfo = ((Search?) -> Void)
    typealias MyQueueStateInfo = ((Int, MyQueueState?) -> Void)
    
    init() {}

    ///스터디 함께할 새싹 찾기 요청
    func queueRequest(lat: Double, long: Double, studylist: [String], completionHandler: @escaping completionHandler ) {
        let api = APIHeader.queue(lat: lat, long: long, studylist: studylist)
        AF.request(api.url, method: api.method, parameters: api.parameters , encoding: URLEncoding(arrayEncoding: .noBrackets), headers: api.headers).responseData { response in
            switch response.result {
            case .success(let data):
                print(data)
                completionHandler(true, response.response!.statusCode)
            case .failure(let error):
                print("profile fail: \(error)")
                //                completionHandler(error)
            }
        }
    }
    
    /// 스터디를 함께할 새싹 찾기 중단
    func searchStopRequest(idtoken: String, completionHandler: @escaping completionHandler) {
        let api = APIHeader.searchStop(idtoken: idtoken)
        AF.request(api.url, method: .delete, parameters: api.parameters, headers: api.headers).validate().response { response in
            switch response.result{
            case .success :
                completionHandler(true, response.response!.statusCode)
            case .failure(let error):
                print("profile fail: \(error)")
                //                completionHandler(error)
            }
        }
    }
    
    /// 스터디를 함께할 새싹 검색
    func searchRequest(lat: Double, long: Double, completionHandler: @escaping SearchInfo) {

        let api = APIHeader.search(lat: lat, long: long)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().responseDecodable(of: Search.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
            case .failure(let error):
                print("profile fail: \(error)")
                //                completionHandler(error)
            }
                
            }
        }
    
    
    /// 서용자의 매칭상태 확인
    func myqueueStateRequest(idtoken: String, completionHandler: @escaping MyQueueStateInfo) {
        
        let api = APIHeader.myQueueState(idtoken: idtoken)
        AF.request(api.url, method: api.method, parameters: api.parameters, headers: api.headers).validate().responseDecodable(of: MyQueueState.self) { response in
            
            switch response.result{
            case .success(let data):
                print(data)
                print(data)
                completionHandler(response.response!.statusCode, data)
            case .failure(let error):
                completionHandler(response.response!.statusCode, nil)
                //                completionHandler(error)
            }
        }
    }
    
}
