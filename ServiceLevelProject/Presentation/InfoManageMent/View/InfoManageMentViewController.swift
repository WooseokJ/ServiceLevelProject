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
//    var reSelect = false
    override func loadView() {
        super.view = infoManageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoManageView.tableView.delegate = self
        infoManageView.tableView.dataSource = self
        
        infoManageView.secondTableView.delegate = self
        infoManageView.secondTableView.dataSource = self
        navigationItem.title = "정보 관리"
        
        infoManageView.tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerViewID)
//        infoManageView.collectionview.collectionViewLayout = createLayout()
//        infoManageView.collectionview.alwaysBounceVertical = false
        infoManageView.collectionview.delegate = self
        infoManageView.collectionview.dataSource = self
        infoManageView.secondCollectionView.delegate = self
        infoManageView.secondCollectionView.dataSource = self
    }
}

