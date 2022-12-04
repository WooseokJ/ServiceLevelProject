////
////  MypageProtocol.swift
////  ServiceLevelProject
////
////  Created by useok on 2022/12/04.
////
//
//import Foundation
//
//protocol MypageProtocol: APIProtocol {
//    var apiUser: APIUser {get}
//
//}
//
//extension MypageProtocol where Self: InfoManageMentViewController {
//    var apiUser: APIUser {
//        return APIUser()
//    }
//
//    func myPageUpdate(completionHandler: @escaping ((MypageInfo?) -> Void) ) {
//
//        self.apiUser.myPageUpdate{ [weak self] data in
//            do {
//                switch data {
//                case .success:
//                    let transData = try data.get()
//                    completionHandler(transData)
//
//                case .failure(.tokenErorr):
//                    self?.refreshIdToken {
//                        self?.myPageUpdate {_ in
//                            print("토큰 갱신")
//                        }
//                    }
//                case .failure(.notUserError):
//                    self?.view.makeToast("새싹 스터디 서버에 최종 가입이 되지 않은 미가입 유저")
//
//                case .failure(.serverError):
//                    self?.view.makeToast("서버 에러")
//                case .failure(.clientError):
//                    self?.view.makeToast("클라이언트 에러")
//                }
//
//            }
//            catch {
//                print("에러야")
//                return
//            }
//        }
//    }
//
//
//}
