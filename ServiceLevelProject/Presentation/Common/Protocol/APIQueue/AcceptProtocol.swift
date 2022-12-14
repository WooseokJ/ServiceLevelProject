//
//  AcceptProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import Foundation

protocol AcceptProtocol: APIQueueProtocol, APIQueueProtocol {
    
    func studyPostAccept(otheruid: String)
}

extension AcceptProtocol where Self: AcceptViewController {

    
    
    func studyPostAccept(otheruid: String) {
        apiQueue.studyPostAccept(otheruid: otheruid) { [weak self] data in
            do {
                switch data {
                case .success:
                    print(data)
                    self?.view.makeToast("스터디 수락 성공")
                    let cattingVC = ChattingViewController()
                    self?.transition(cattingVC, transitionStyle: .push)
                
                case .failure(.opponentToOtherMettingError):
                    self?.view.makeToast("상대방이 이미 다른 새싹과 스터디를 함께 하는 중입니다")
                    
                case .failure(.stopSesacSearchError):
                    self?.view.makeToast("상대방이 스터디찾기를 그만두었습니다.")
                    
                case .failure(.myToOtherMatchedError):
                    self?.view.makeToast("앗! 누군가가 나의 스터디를 수락하였어요!")
                    self?.callmyqueueStateRequest()

                    
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.studyPostAccept(otheruid: otheruid)
                    }
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
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
    
    
    func callmyqueueStateRequest() {
        apiQueue.myqueueStateRequest() { [weak self] data in
            do {
                switch data {
                case .success :
                    guard try data.get()!.matched == 0 else {
                        let chattingVC = ChattingViewController()
                        self?.transition(chattingVC, transitionStyle: .push)
                        return
                    }
                case .failure(.notRequest):
                    let searchVC = SearchViewController()
                    searchVC.transferSearchInfo = self?.transferSearchInfo
                    self?.transition(searchVC, transitionStyle: .push)
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.callmyqueueStateRequest()
                    }
                case .failure(.notUserError):
                    self?.view.makeToast("미가입회원")
                case .failure(.serverError):
                    self?.view.makeToast("서버에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트에러")
                default:
                    print("모르는 에러")
                }
            }
            catch {
                print("알수없는오류")
            }
           
        }
    }
}
