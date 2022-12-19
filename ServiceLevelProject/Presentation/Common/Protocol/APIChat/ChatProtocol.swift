//
//  ChatProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import Foundation

protocol ChatProtocol: APIProtocol {
    var apiChat: APIChat {get}
    func chatPostSend(chat: String, to: String)
    
    
}

extension ChatProtocol where Self: ChattingViewController {
    var apiChat: APIChat {
        return APIChat()
    }
    
    func chatPostSend(chat: String, to: String) {
        apiChat.chatPostSend(chat: chat, to: to) { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    self?.view.makeToast("채팅 전송 성공")
                case .failure(.notSendState):
                    self?.view.makeToast("상대방에게 채팅을 보낼 수 없는, 일반 상태")
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.chatPostSend(chat: chat, to: to)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch {
                print("에러야")
                return
            }
        }
    }
    
    func chatPostList(lastchatDate: String, from: String, completionHandler: @escaping ((ChatListInfo?) -> Void)) {
        
        
        apiChat.chatPostList(lastchatDate: lastchatDate, from: from) {[weak self] data in
            do {
                switch data {
                case .success:
                   
                    self?.view.makeToast("채팅목록 가져오기 성공")
                    SocketIOManager.shared.establishConnetion()

                    let transData = try data.get()
//                    print(transData)
                    completionHandler(transData)
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.chatPostList(lastchatDate: lastchatDate, from: from) { _ in
                            self?.view.makeToast("토큰 만료후 재시도")
                        }
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
                
            }
            
            catch {
                print("에러야")
                return
            }
        }
        
    }
}




