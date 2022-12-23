//
//  DodgeProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import Foundation

protocol DodgeProtocol: APIProtocol, APIQueueProtocol  {
    func studyPostDodge(otheruid: String)
}

extension DodgeProtocol where Self: ChattingViewController {

    
    func studyPostDodge(otheruid: String) {
        apiQueue.studyPostDodge(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    self?.view.makeToast("스터디 취소 성공")
                case .failure(.otherUIDError):
                    self?.view.makeToast("잘못된 otheruid 요청")
 
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostDodge(otheruid: otheruid)
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

