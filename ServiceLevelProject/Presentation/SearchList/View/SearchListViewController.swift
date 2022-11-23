//
//  SearchListViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/23.
//

import UIKit
import Tabman
import Pageboy

class SearchListViewController: TabmanViewController {

    var VCS: Array<UIViewController> = [AroundSeSacViewController(), ResponseViewController()]

    
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
        self.navigationController?.popToRootViewController(animated: true)
    }

}
