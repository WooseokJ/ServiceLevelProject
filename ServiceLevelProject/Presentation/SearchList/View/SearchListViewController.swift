//
//  SearchListViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/23.
//

import UIKit
import Tabman
import Pageboy
import Toast

class SearchListViewController: TabmanViewController, APIProtocol{
    var transferSearchInfo: Search?
    

    let searchListView = SearchListView()
    
    
    var VCS: Array<UIViewController> = [AroundSeSacViewController(), ResponseViewController()]
//    let apiQueue = APIQueue()
    
    var searchInfo: Search?
    override func loadView() {
        super.view = searchListView
        title = "새싹찾기"
        view.backgroundColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.dataSource = self
        addBar(searchListView.bar, dataSource: self, at: .custom(view: searchListView.tampView , layout: nil))
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(searchCancelClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtClicked))
    }
    
    @objc func searchCancelClicked() {
//        apiQueue.searchStopRequest(idtoken: UserDefaults.standard.string(forKey: "token")!) { [self] statusCode in
//            switch statusCode{
//            case CommonError.success.rawValue :
//                view.makeToast("찾기 중단 성공")
//                self.navigationController?.popToRootViewController(animated: true)
//            case CommonError.tokenErorr.rawValue: //401
//                print("")
////                self.refreshIdToken()
////                DispatchQueue.main.async {
////                    self.refreshIdToken()
////                }
//            case CommonError.notUserError.rawValue:
//                view.makeToast("미가입 회원")
//            case CommonError.serverError.rawValue:
//                view.makeToast("서버에러")
//            case CommonError.clientError.rawValue:
//                view.makeToast("클라이언트 에러")
//            default:break
//            }
//        }
    }
    
    @objc func backBtClicked() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: true)
    }
}
