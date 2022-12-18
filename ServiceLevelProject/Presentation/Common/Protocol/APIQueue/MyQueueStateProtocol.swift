//
//  MyQueueStateProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/18.
//

import Foundation

protocol MyQueueStateProtocol {
    func callmyqueueStateRequest()
}

extension MyQueueStateProtocol where Self : SearchListViewController {
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
