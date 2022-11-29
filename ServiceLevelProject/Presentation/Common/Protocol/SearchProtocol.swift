//
//  SearchProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import Foundation

protocol SearchProtocol: APIProtocol, TransferDataProtocol {
    var searchView: SearchView {get}
    func queuePostRequest(lat: Double, long: Double, studylist: [String])
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
                    view.makeToast("새싹 찾기 성공")
                    let searchListVC = SearchListViewController()
                    transition(searchListVC, transitionStyle: .push)
                case .failure(.reportedThirdUser):
                    print("fail")
                case .failure(.panaltyOneUser):  view.makeToast("스터디 취소 패널티1단계")
                case .failure(.panaltyTwoUeer): view.makeToast("스터디 취소 패널티2단계")
                case .failure(.panaltyThirdUser): view.makeToast("스터디 취소 패널티3단계")
                case .failure(.tokenErorr):
                    view.makeToast("토큰만료")
                    refreshIdToken {
                        queuePostRequest(lat: lat, long: long, studylist: studylist)
                    }
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
