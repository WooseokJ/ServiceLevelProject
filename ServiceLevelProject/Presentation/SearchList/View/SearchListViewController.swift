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

class SearchListViewController: TabmanViewController, APIProtocol, ButtonProtocol{

    var VCS: Array<UIViewController> = [AroundSeSacViewController(), ResponseViewController()]
    
    let apiQueue = APIQueue()
    
    
    var searchListView = SearchListView()
    override func loadView() {
        super.view = searchListView
        title = "새싹찾기"
        view.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        addBar(searchListView.bar, dataSource: self, at: .custom(view: searchListView.tampView , layout: nil))
        let right = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(searchCancelClicked))
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func searchCancelClicked() {
        apiQueue.searchStopRequest(idtoken: UserDefaults.standard.string(forKey: "token")!) { [self] bool, statusCode in
            switch statusCode{
            case CommonError.success.rawValue :
                view.makeToast("찾기 중단 성공")
                self.navigationController?.popToRootViewController(animated: true)
            case CommonError.tokenErorr.rawValue: //401
                DispatchQueue.main.async {
                    self.refreshIdToken()
                }
            case CommonError.notUserError.rawValue:
                view.makeToast("미가입 회원")
            case CommonError.serverError.rawValue:
                view.makeToast("서버에러")
            case CommonError.clientError.rawValue:
                view.makeToast("클라이언트 에러")
            default:
                print("알수없는오류")
            }
        }
    }

}
