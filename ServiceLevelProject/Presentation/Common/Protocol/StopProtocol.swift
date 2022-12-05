////
////  StopProtocol.swift
////  ServiceLevelProject
////
////  Created by useok on 2022/12/04.
////
//
//import Foundation
//
//protocol StopProtocol: APIProtocol {
//    var apiQueue: APIQueue { get }
//}
//
//extension StopProtocol where Self: AroundSeSacViewController {
//    
//    var apiQueue: APIQueue {
//        return APIQueue()
//    }
//    
////    func stopQueue() {
//        self.apiQueue.searchStopRequest() { [weak self] data in
//            switch data {
//            case .success :
//                self?.view.makeToast("찾기 중단 성공")
//                self?.navigationController?.popToRootViewController(animated: true)
//            case .failure(.alreadyStopError):
//                self?.view.makeToast("새싹 찾기는 이미 중단된 상태")
//            case .failure(.notUserError):
//                self?.view.makeToast("미가입 회원")
//            case .failure(.tokenErorr):
//                self?.refreshIdToken {
//                    self?.stopQueue()
//                }
//            case .failure(.serverError):
//                self?.view.makeToast("서버에러")
//            case .failure(.clientError):
//                self?.view.makeToast("클라이언트 에러")
//            default:break
//            }
//        }
//    }
//}
//
//
////extension StopProtocol where Self: AroundSeSacViewController {
////
////    func stopQueue() {
////
////        self.apiQueue.searchStopRequest { [weak self] data in
////            switch data {
////            case .success :
////                self?.view.makeToast("찾기 중단 성공")
////                self?.navigationController?.popToRootViewController(animated: true)
////            case .failure(.alreadyStopError):
////                self?.view.makeToast("새싹 찾기는 이미 중단된 상태")
////            case .failure(.notUserError):
////                self?.view.makeToast("미가입 회원")
////            case .failure(.tokenErorr):
////                self?.refreshIdToken {
////                    self?.stopQueue()
////                }
////            case .failure(.serverError):
////                self?.view.makeToast("서버에러")
////            case .failure(.clientError):
////                self?.view.makeToast("클라이언트 에러")
////            default:break
////            }
////        }
////    }
////}
