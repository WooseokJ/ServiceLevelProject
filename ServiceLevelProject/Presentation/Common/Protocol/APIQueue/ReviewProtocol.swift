//
//  ReviewProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/08.
//

import UIKit

protocol ReviewProtocol: APIQueueProtocol {
    func reviewPostRate(otheruid: String, reputation: [Int], comment: String)
}

extension ReviewProtocol where Self: ChattingViewController {
    
    func reviewPostRate(otheruid: String, reputation: [Int], comment: String) {
        self.apiQueue.reviewPostRate(otheruid: otheruid, reputation: reputation, comment: comment) {  [weak self] data in
            do {
                switch data {
                case .success:
                    let viewControllers : [UIViewController] = self?.navigationController!.viewControllers as [UIViewController]
                    self?.navigationController?.popToViewController(viewControllers[0], animated: true)
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.reviewPostRate(otheruid: otheruid, reputation: reputation, comment: comment)
                    }
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
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
//    { [weak self] data in
//        do {
//            switch data {
//            case .success:
//                let viewControllers : [UIViewController] = self?.navigationController!.viewControllers as [UIViewController]
//                self?.navigationController?.popToViewController(viewControllers[0], animated: true)
//            case .failure(.tokenErorr):
//                self?.refreshIdToken {
//                    self?.reviewPostRate(otheruid: otheruid, reputation: reputation, comment: comment)
//                }
//            case .failure(.notUserError):
//                self?.view.makeToast("미가입 회원")
//            case .failure(.serverError):
//                self?.view.makeToast("서버 에러")
//            case .failure(.clientError):
//                self?.view.makeToast("클라이언트 에러")
//            }
//        }
//        catch {
//            print("에러야")
//            return
//        }
//    }
//}
