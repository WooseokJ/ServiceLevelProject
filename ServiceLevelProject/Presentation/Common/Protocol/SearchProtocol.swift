//
//  SearchProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import Foundation

protocol SearchProtocol: TransferDataProtocol, APIProtocol, callSearchProtocol {
    var searchView: SearchView {get}
    func queuePostRequest(lat: Double, long: Double, studylist: [String])
}

extension callSearchProtocol where Self: SearchViewController {
    func callSearch(lat: Double, long: Double) {
        self.apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
            do {
                switch data {
                case .success:
                    let test = try data.get().value!
                    let searchListVC = SearchListViewController()
                    searchListVC.transferSearchInfo = test
                    self?.transition(searchListVC, transitionStyle: .push)
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.callSearch(lat: lat, long: long)
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch{print("에러야")}
            }
        
        }
}


extension SearchProtocol where Self: SearchViewController {
    var searchView: SearchView {
        return searchView
    }
    
    func queuePostRequest(lat: Double, long: Double, studylist: [String]) {
        self.apiQueue.queueRequest(lat: lat, long: long ,studylist: studylist ) { [self] data  in
            do {
                switch data {
                case .success:
                    callSearch(lat: lat, long: long)
                case .failure(.reportedThirdUser):
                    print("fail")
                case .failure(.panaltyOneUser):  view.makeToast("스터디 취소 패널티1단계")
                case .failure(.panaltyTwoUeer): view.makeToast("스터디 취소 패널티2단계")
                case .failure(.panaltyThirdUser): view.makeToast("스터디 취소 패널티3단계")
                case .failure(.tokenErorr):
                    view.makeToast("토큰만료")
                    refreshIdToken()
                    queuePostRequest(lat: lat, long: long, studylist: studylist)
                case .failure(.notUserError): view.makeToast("미가입회원")
                case .failure(.serverError): view.makeToast("server Error")
                case .failure(.clientError): view.makeToast("client Error")
                default:
                    view.makeToast("알수없는오류")
                    break
                    
                }
            }
            catch {}
        }
  
        
    }

}
