//
//  ChattingViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit
import RxSwift
import RxCocoa

class ChattingViewController: BaseViewController, DodgeProtocol, ChatProtocol {

    
    let chattingView = ChattingView()
    
    override func loadView() {
        super.view = chattingView
    }
    
    var otherid: String?
    var recentChattingInfo: ChatListInfo?
    
    var chat: [Payload?] = []
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "고래밥"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(listClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtClicked))
        
        chattingView.dateTitleLabel.text = "1월 15일 토요일"
        chattingView.matchedTitle.text = "고래밥님과 매칭되었습니다."
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name:UIResponder.keyboardWillHideNotification, object: self.view.window)
        configureTableView()
        
        var lastchatDate: String = "2000-01-01T00:00:00.000Z"
        chatPostList(lastchatDate: lastchatDate, from: UserDefaults.standard.string(forKey: "otheruid")!) { [weak self] data in
            self?.recentChattingInfo = data
            print(self?.recentChattingInfo)
            self?.recentChattingInfo?.payload.forEach{
                self?.chat.append($0)
            }
            self?.chattingView.tableView.reloadData()

        }
        
//        bind()
        
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
        studyPostDodge(otheruid: UserDefaults.standard.string(forKey: "otheruid")!)
    }

    @objc func backBtClicked() {
        let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController?.popToViewController(viewControllers[0], animated: true)
    }

}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        chattingView.tableView.delegate = self
        chattingView.tableView.dataSource = self
        chattingView.tableView.allowsSelection = false
        chattingView.tableView.separatorStyle = .none
        chattingView.tableView.rowHeight = UITableView.automaticDimension
        chattingView.tableView.backgroundColor = .darkGray
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let data = chat[indexPath.row]
        if data?.id == UserDefaults.standard.string(forKey: "otheruid") {

            let cell = tableView.dequeueReusableCell(withIdentifier: MychatTableViewCell.reuseIdentifier, for: indexPath) as! MychatTableViewCell
            cell.myChatLabel.text = data?.chat!
            cell.backgroundColor = .brown
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier, for: indexPath) as! YourChatTableViewCell
            cell.yourChatLabel.text = data?.chat!
            cell.yourChatLabel.backgroundColor = .yellow
            cell.backgroundColor = .cyan
            cell.yourChatLabel.layer.cornerRadius = 8
            cell.yourChatLabel.layer.borderWidth = 1
            cell.yourChatLabel.layer.borderColor = UIColor.red.cgColor
            return cell

        }
        
        

    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UIScreen.main.bounds.height * 0.1
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    
}


//extension ChattingViewController {
//    func bind() {
//        chattingView.sendButton.rx
//            .tap
//            .map {self.chattingView.tableView.text}
//            .withUnretained(self)
//
//            .bind { (vc,val) in
//                print(val)
//            }
//            .disposed(by: disposeBag)
//
//    }
//}