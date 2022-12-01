//
//  AroundProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/30.
//

import Foundation

protocol AroundProtocol {
    func studyPostRequest(otheruid: String)
    var apiQueue: APIQueue {get}
}

extension AroundProtocol where Self: AroundSeSacViewController {

    var apiQueue: APIQueue {
        return APIQueue()
    }
    
    func studyPostRequest(otheruid: String) {
        apiQueue.studyPostRequest(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    //                    completionHandler(try data.get().value!)
                    print(data)
                    self?.view.makeToast("스터디 요청을 보냈습니다")
                case .failure(.alreadyTomeRequest):
                    self?.view.makeToast("상대방이 이미 나에게 스터디 요청한 상태")
                    self?.studyPostAccept(otheruid: otheruid)
                case .failure(.oppnentStopRequest):
                    self?.view.makeToast("상대방이 스터디찾기를 그만두었습니다.")
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostRequest(otheruid: otheruid)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                    
                }
            }
            catch{print("에러야")}
        }
    }
    
    func studyPostAccept(otheruid: String) {
        apiQueue.studyPostAccept(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    self?.view.makeToast("스터디 수락 성공")
                case .failure(.opponentToOtherMettingError):
                    self?.view.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다")
                case .failure(.stopSesacSearchError):
                    self?.view.makeToast("상대방이 스터디찾기를 그만두었습니다.")
                case .failure(.myToOtherMatchedError):
                    self?.view.makeToast("상앗! 누군가가 나의 스터디를 수락하였어요!")
                    
                    
                    
                    
                    
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostAccept(otheruid: otheruid)
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                    
                }
            }
            catch{
                print("에러야")
                return
            }
        }
    }
    
}
