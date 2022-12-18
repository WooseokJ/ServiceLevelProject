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

class SearchListViewController: TabmanViewController, TransferDataProtocol, APIProtocol, StopProtocol, MyQueueStateProtocol {

    var transferSearchInfo: Search?

    var testtest: Search?
    
    let searchListView = SearchListView()
    
    var disposeBag = DisposeBag()
    
    var timer: Timer? // 타이머

    var VCS: Array<UIViewController> = [AroundSeSacViewController(), AcceptViewController()]
    
    override func loadView() {
        super.view = searchListView
        title = "새싹찾기"
        view.backgroundColor = .white
    }

    
    override func viewWillAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [self] timer in
            self.callmyqueueStateRequest()
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        addBar(searchListView.bar, dataSource: self, at: .custom(view: searchListView.tampView , layout: nil))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(searchCancelClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtClicked))
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }

    @objc func searchCancelClicked() {
        stopQueue()
    }
    
    @objc func backBtClicked() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[0], animated: true)
    }
    
}
