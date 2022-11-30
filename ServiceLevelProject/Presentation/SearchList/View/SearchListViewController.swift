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
import RxSwift
import RxCocoa

class SearchListViewController: TabmanViewController, TransferDataProtocol, APIProtocol {

    var transferSearchInfo: Search?

    var testtest: Search?
    
    let searchListView = SearchListView()
    
    var disposeBag = DisposeBag()
    
    var VCS: Array<UIViewController> = [AroundSeSacViewController(), ResponseViewController()]
    
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
                    searchCancelClicked()
                }
            case .failure(.serverError):
                view.makeToast("서버에러")
            case .failure(.clientError):
                view.makeToast("클라이언트 에러")
            default:break
            }
        }
    }
    
    @objc func backBtClicked() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[0], animated: true)
    }
    
}
