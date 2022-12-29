//
//  ChattingViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class ChattingViewController: BaseViewController, DodgeProtocol, ChatProtocol, ReviewProtocol {

    
    let chattingView = ChattingView()
    
    override func loadView() {
        super.view = chattingView
    }
    
    var otherid: String?
    var recentChattingInfo: ChatListInfo?
    var sesacList: [Int] = [0,0,0,0,0,0]
    
//    var chat: [Payload?] = []
    var chat: Results<ChatData>?
    let repository = Repository()

    var test: Int = 0
    var date: Date?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        date = Date()
        chattingView.dateTitleLabel.text = "\(date!.month)월 \(date!.day)일 \(getDayOfWeek(date: date!))요일"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        repository.tasks
//        print(repository.tasks.value)
        

        chattingView.textView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(listClicked))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtClicked))
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage2(notification:)), name: Notification.Name("getMessage"), object: nil)
        
        title = "고래밥"
        chattingView.matchedTitle.text = "고래밥님과 매칭되었습니다."
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name:UIResponder.keyboardWillHideNotification, object: self.view.window)

        aboutKeyboard()
        hideKeyboard()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blackViewTap(sender:)))
        chattingView.blackView.addGestureRecognizer(tapGesture)
        
        let keyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTap(sender:)))
        chattingView.tableView.addGestureRecognizer(keyBoardGesture)
        bind()
        
        let lastchatDate: String = recentChattingInfo?.payload[0].createdAt ?? "2000-01-01T00:00:00.000Z"
        chatPostList(lastchatDate: lastchatDate, from: UserDefaults.standard.string(forKey: "otheruid")!) { [weak self] data in
            self?.recentChattingInfo = data
            do {
                print(self?.repository.localRealm.configuration.fileURL! as Any)
                try self?.repository.localRealm.write {
                    self?.repository.localRealm.deleteAll()
                    self?.test = (data?.payload.count)!
                    data?.payload.forEach{
                        let value = ChatData(to: $0.to!, from: $0.from!, chat: $0.chat!, createdAt: $0.createdAt!)
                        self?.repository.localRealm.add(value)
                    }
                }
                self?.configureTableView()
                self?.collectionViewConfigure()
            }catch let error {print(error)}
        }        
    }
    
    func getDayOfWeek(date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEEEE"
            formatter.locale = Locale(identifier:"ko_KR")
            let convertStr = formatter.string(from: date)
            return convertStr
    }
    
    
    @objc func getMessage2(notification: NSNotification) {
        self.chattingView.tableView.reloadData()
        self.chattingView.tableView.scrollToRow(at: IndexPath(row: self.chat!.count - 1, section: 0), at: .bottom, animated: false)


    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SocketIOManager.shared.closeConnection()
    }

    @objc func tableViewTap(sender: UITapGestureRecognizer) {
        chattingView.stackView.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        view.endEditing(true)
    }
    
        
    
    @objc func keyboardShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            chattingView.stackView.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(100) //keyboardSize.height
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
    
    // 오른쪽 메뉴바 버튼 클릭
    @objc func listClicked() {
        chattingView.listButtonClicked()
    }
    // 블랙뷰 탭할떄
    @objc func blackViewTap(sender: UITapGestureRecognizer) {
        chattingView.blackViewClicked()
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chat?.count ?? test
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        chat = repository.fetch()
        
        let data = chat?[indexPath.row]
        if data?.from == UserDefaults.standard.string(forKey: "otheruid")! {
            let cell = tableView.dequeueReusableCell(withIdentifier: YourChatTableViewCell.reuseIdentifier, for: indexPath) as! YourChatTableViewCell
            cell.yourChatLabel.text = data!.chat
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MychatTableViewCell.reuseIdentifier, for: indexPath) as! MychatTableViewCell
            cell.myChatLabel.text = data!.chat
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ChattingViewController {
    func bind() {
        // 메세지 전송
        chattingView.sendButton.rx
            .tap
            .map {self.chattingView.sendTextView.text}
            .withUnretained(self)
            .bind { (vc,val) in
                vc.chatPostSend(chat: val!, to: UserDefaults.standard.string(forKey: "otheruid")!)
                vc.chattingView.sendTextView.text = ""
//                let chatContent = ChatData(to:UserDefaults.standard.string(forKey: "otheruid")! , from: UserDefaults.standard.string(forKey: "Myuid")!, chat: val!, createdAt: "")
//                self.repository.addChat(item: chatContent)
                
                vc.chattingView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        
        // 스터디 취소
        chattingView.studyCancel.rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                
                vc.studyPostDodge(otheruid: UserDefaults.standard.string(forKey: "otheruid")!)
                vc.backBtClicked()
            }
            .disposed(by: disposeBag)
        
        // 리뷰등록 클릭
        chattingView.reviewAdd.rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.chattingView.blackView.isUserInteractionEnabled = false
                vc.chattingView.reviewAdd.isSelected.toggle()
                vc.chattingView.collectionview.collectionViewLayout = vc.chattingView.collectionViewLayout(divideWidth: 2.5)
                vc.chattingView.collectionview.collectionViewLayout.invalidateLayout()
                vc.chattingView.modalButtonClicked(title: "리뷰 등록", subTitle: "고래밥님과의 스터디는 어떠셨나요?", BtTitle: "리뷰 등록하기")
            }
            .disposed(by: disposeBag)
        
        //새싹신고 클릭
        chattingView.sesacReport.rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.chattingView.blackView.isUserInteractionEnabled = false
                vc.chattingView.sesacReport.isSelected.toggle()
                vc.chattingView.collectionview.collectionViewLayout = vc.chattingView.collectionViewLayout(divideWidth: 4)
                vc.chattingView.collectionview.collectionViewLayout.invalidateLayout()
                vc.chattingView.modalButtonClicked(title: "세씩 신고", subTitle: "다시는 해당 새싹과매칭되지 않습니다", BtTitle: "신고하기")
            }
            .disposed(by: disposeBag)
        
        // 취소버튼 클릭
        chattingView.cancelXMark.rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.chattingView.textView.text = ""
                vc.chattingView.blackView.isUserInteractionEnabled = true
                if vc.chattingView.reviewAdd.isSelected {
                    vc.chattingView.reviewAdd.isSelected.toggle()
                }else{
                    vc.chattingView.sesacReport.isSelected.toggle()
                }                
                vc.chattingView.blackViewClicked()
            }
            .disposed(by: disposeBag)
        
        // 모달버튼누를떄
        chattingView.modalButton.rx
            .tap
            .map {
                self.chattingView.textView.text
            }
            .withUnretained(self)
            .bind { (vc,val) in
                vc.reviewPostRate(otheruid: "cgP8iswqFEO4VpPxpcWKUbtr0t22", reputation: vc.sesacList, comment: val!)
                vc.chattingView.blackViewClicked()
                let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController?.popToViewController(viewControllers[0], animated: true)
                
            } //vc.otherid!
            .disposed(by: disposeBag)

    }
}


