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
        aboutKeyboard()
        
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
        hideKeyboard()
    }
    
    
    @objc func saveButtonClicked() {
        print(#function)
    }
}

//        infoManageView.collectionview.alwaysBounceVertical = false

extension InfoManageMentViewController {
    
    func aboutKeyboard() {
            // Register Keyboard notifications
            // addObserver를 통해 옵저버를 설정할 대상을 뷰컨트롤러 객체(self)로 지정
            NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillHide(_:)),name: UIResponder.keyboardWillHideNotification,object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),name: UIResponder.keyboardWillShowNotification,object: nil)
        }
        
        @objc func keyboardWillShow(_ sender:Notification){
            self.view.frame.origin.y = -150
        }
        
        //키보드 내려갔다는 알림을 받으면 실행되는 메서드
        @objc func keyboardWillHide(_ sender:Notification){
            self.view.frame.origin.y = 0
        }
}
