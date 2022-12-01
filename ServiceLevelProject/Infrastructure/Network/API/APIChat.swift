//
//  APIChat.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import Foundation
import Alamofire

final class APIChat {
    typealias ChatSendHandler = ((Result<ChatSendInfo, chatSendError>) -> Void)
    typealias ChatListHandler = ((Result<ChatListInfo, chatListError>) -> Void)
    
    init() {}
    
    /// 채팅 보내기
    func chatPostSend(chat: String, to: String, completionHandler: @escaping ChatSendHandler) {
        let api = APIHeader.chatPostSend(chat: chat, to: to)
        AF.request(api.url, method: api.method, headers: api.headers).validate().responseDecodable(of: ChatSendInfo.self) { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = chatSendError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(chatSendError(rawValue: customError.rawValue)!))
            }
        }
    }
    
    /// 채팅 리스트(목록)
    func chatPostList(lastchatDate: String, from: String,  completionHandler: @escaping ChatListHandler) {
        let api = APIHeader.chatGetList(lastchatDate: lastchatDate, from: from)
        AF.request(api.url, method: api.method, headers: api.headers).validate().responseDecodable(of: ChatListInfo.self) { response in
            switch response.result {
            case .success(let data) :
                completionHandler(.success(data))
            case .failure:
                guard let customError = chatListError(rawValue: response.response!.statusCode) else{return}
                completionHandler(.failure(chatListError(rawValue: customError.rawValue)!))
            }
        }
    }
}
