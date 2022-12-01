//
//  ChattingViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit

class ChattingViewController: BaseViewController, DodgeProtocol, ChatProtocol {

    
    let chattingView = ChattingView()
    
    override func loadView() {
        super.view = chattingView
    }
    
    var otherid: String?
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "고래밥"
        let right = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(listClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtClicked))
        chattingView.dateTitleLabel.text = "1월 15일 토요일"
        chattingView.matchedTitle.text = "고래밥님과 매칭되었습니다."
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name:UIResponder.keyboardWillHideNotification, object: self.view.window)
        
    }
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            chattingView.stackView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardSize.height )
                make.leading.equalTo(0)
                make.trailing.equalTo(0)
                make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            }

        }
    }
    @objc func keyboardHide(notification: NSNotification) {
        chattingView.stackView.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }

    }
    
    @objc func listClicked() {
        self.view.makeToast("모달")
//        studyPostDodge(otheruid: <#T##String#>)
    }

    @objc func backBtClicked() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[0], animated: true)
    }

}
