//
//  StopProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/04.
//

import Foundation

protocol StopProtocol: APIProtocol, APIQueueProtocol {
    func stopQueue() 
}

extension StopProtocol where Self: AroundSeSacViewController {
    
    func stopQueue() {
    apiQueue.searchStopRequest() { [self] data in
            switch data {
            case .success :
                view.makeToast("찾기 중단 성공")
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(.alreadyStopError):
                view.makeToast("새싹 찾기는 이미 중단된 상태")
            case .failure(.notUserError):
                view.makeToast("미가입 회원")
            case .failure(.tokenErorr):
                refreshIdToken {
                    stopQueue()
                }
            case .failure(.serverError):
                view.makeToast("서버에러")
            case .failure(.clientError):
                view.makeToast("클라이언트 에러")
            default:break
            }
        }
    }
}

extension StopProtocol where Self: SearchListViewController {
    func stopQueue() {
    apiQueue.searchStopRequest() { [self] data in
            switch data {
            case .success :
                view.makeToast("찾기 중단 성공")
                self.navigationController?.popToRootViewController(animated: true)
            case .failure(.alreadyStopError):
                view.makeToast("새싹 찾기는 이미 중단된 상태")
            case .failure(.notUserError):
                view.makeToast("미가입 회원")
            case .failure(.tokenErorr):
                refreshIdToken {
                    stopQueue()
                }
            case .failure(.serverError):
                view.makeToast("서버에러")
            case .failure(.clientError):
                view.makeToast("클라이언트 에러")
            default:break
            }
        }
    }
}
