//
//  ResponseViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class AcceptViewController: BaseViewController, callSearchProtocol, AcceptProtocol {


    var isSelect = true
    var testSelect = true
    var transferSearchInfo: Search?

    var searchListView = SearchListView()
    override func loadView() {
        super.view = searchListView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.callSearch(lat: HomeViewController.lat!, long: HomeViewController.lng!, completionHandler: { [weak self] search in
            self?.transferSearchInfo = search
            dump(self?.transferSearchInfo?.fromQueueDBRequested)
            self?.searchListView.tableView.reloadData()
            if self?.transferSearchInfo?.fromQueueDBRequested.count == 0 {
                self?.searchListView.content.text = "아직 받은 요청이 없어요ㅠ"
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView.TableViewSetConstrains()
        tableviewConfigure()
        bind()
    }
    
}

//MARK: 테이블뷰
extension AcceptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableviewConfigure() {
        searchListView.tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerViewID)
        searchListView.tableView.delegate = self
        searchListView.tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.transferSearchInfo?.fromQueueDBRequested.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier, for: indexPath) as! SearchListTableViewCell
        cell.reviewLabel.text = self.transferSearchInfo?.fromQueueDBRequested[indexPath.section].nick
        searchListView.checkButton.tag = indexPath.section
//        cell.backgroundColor = .darkGray
        cell.selectionStyle = .none
        bind(cell: cell, indexPath: indexPath)
        return cell
    }
    

    private func bind(cell: SearchListTableViewCell, indexPath: IndexPath) {
        cell.moreButton.rx.tap
            .bind { val in
                print(indexPath)
//                self.tableView(self.searchListView.tableView, heightForRowAt: indexPath)
                self.isSelect.toggle()
                self.testSelect.toggle()
                self.searchListView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.headerViewID) as? HeaderView else {
            return UIView()
        }
        
        headerView.image.isHidden = false
        headerView.acceptButtonConstrains()
        headerView.acceptButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.acceptSetConstrains()
            }
            .disposed(by: disposeBag)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 
    }
    
    
}
extension AcceptViewController {
    private func bind() {
        // 취소하기 버튼
        searchListView.cancelButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.cancelButtonClicked()
                vc.searchListView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        // 수락하기 버튼 클릭
        searchListView.checkButton.rx
            .tap
            .map{self.transferSearchInfo?.fromQueueDBRequested[(self.searchListView.checkButton.tag)].uid}
            .withUnretained(self)
            .bind { (vc,val) in
                UserDefaults.standard.set(val!, forKey: "otheruid")
                vc.studyPostAccept(otheruid: val!)
                vc.searchListView.cancelButtonClicked()
            }
            .disposed(by: disposeBag)
        
        // 새로고침 버튼 클릭
        searchListView.refreshButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.callSearch(lat: HomeViewController.lat!, long: HomeViewController.lng!, completionHandler: { search in
                    vc.transferSearchInfo = search
                    dump(vc.transferSearchInfo)
                    vc.searchListView.tableView.reloadData()
                })
            }
            .disposed(by: disposeBag)
    }
    
}
