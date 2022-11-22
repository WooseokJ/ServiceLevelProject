//
//  InfoManageMentViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit

class InfoManageMentViewController: BaseViewController {

    let infoManageView = InfoManageMentView()
    var isSelect = true
    
    override func loadView() {
        super.view = infoManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoManageView.tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerViewID)
        infoManageView.tableView.delegate = self
        infoManageView.tableView.dataSource = self
        infoManageView.secondTableView.delegate = self
        infoManageView.secondTableView.dataSource = self
        let right = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.title = "정보 관리"
        infoManageView.collectionview.delegate = self
        infoManageView.collectionview.dataSource = self
    }
    
    
    @objc func saveButtonClicked() {
        print(#function)
    }
}

//        infoManageView.collectionview.alwaysBounceVertical = false
