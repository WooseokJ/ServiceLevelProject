//
//  Network.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import Foundation
import Alamofire

final class Network {
    static let shared = Network()
    
    private init() {}
    
    func requestAPI<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod , parameters: [String:String]? = nil , headers: HTTPHeaders, completion: @escaping (Result<T, Error>) -> ()) { // T: 어떤데이터가 올지모르므로

        AF.request(url, method: method, parameters: parameters ,headers: headers)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        guard let statusCode = response.response?.statusCode else {return}
//                        guard let error = SeSacError(rawValue: statusCode) else {return} // rawValue가 406이 들어오면 takeEmail를 error에 담는다
                        completion(.failure(error))
                }
        }
    }
}
