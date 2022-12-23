//
//  AroundSeSacViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class AroundSeSacViewController: BaseViewController, callSearchProtocol, AroundProtocol {
    
    let searchListView = SearchListView()
    var isSelect = true
    var testSelect = true
    var transferSearchInfo: Search?
    var searchTest: Search?
    override func loadView() {
        super.view = searchListView
    }
    override func viewWillAppear(_ animated: Bool) {
        self.callSearch(lat: HomeViewController.lat!, long: HomeViewController.lng!, completionHandler: { [weak self] search in
            self?.transferSearchInfo = search
            dump(search?.fromQueueDB)
            self?.searchListView.tableView.reloadData()
            if self?.transferSearchInfo?.fromQueueDBRequested.count == 0 {
                self?.searchListView.content.text = "아쉽게도 주변에 새삮이 없어요ㅠ"
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView.TableViewSetConstrains()
        tableviewConfigure()
        //        collectionviewConfigure()
        bind()
    }
    
    
}

//MARK: 테이블뷰
extension AroundSeSacViewController: UITableViewDelegate, UITableViewDataSource {
    func tableviewConfigure() {
        searchListView.tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerViewID)
        searchListView.tableView.delegate = self
        searchListView.tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.transferSearchInfo?.fromQueueDB.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier, for: indexPath) as! SearchListTableViewCell
        
        searchListView.checkButton.tag = indexPath.section
        cell.reviewLabel.text = self.transferSearchInfo?.fromQueueDB[indexPath.section].nick
//        cell.backgroundColor = .lightGray
        cell.selectionStyle = .none
//        cell.layer.cornerRadius = 8
//        cell.layer.borderWidth = 1
        
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
        headerView.requestButtonConstrains()
        
        headerView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.requestSetConstrains()
                
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

extension AroundSeSacViewController {
    private func bind() {
        
        // 취소하기 버튼 확인 클릭시 
        searchListView.cancelButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.cancelButtonClicked()
            }
            .disposed(by: disposeBag)
        
        // 요청하기 버튼 확인 클릭시
        searchListView.checkButton
            .rx
            .tap
            .map{self.transferSearchInfo?.fromQueueDB[(self.searchListView.checkButton.tag)].uid}
            .withUnretained(self)
            .bind { (vc,val) in
                print("otheruid",val!)
                UserDefaults.standard.set(val!, forKey: "otheruid")
                vc.studyPostRequest(otheruid: val!)
                vc.searchListView.cancelButtonClicked()
            }
            .disposed(by: disposeBag)
        
        // 새로고침 버튼 클릭
        searchListView.refreshButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.callSearch(lat: HomeViewController.lat!, long: HomeViewController.lng!) { [weak self] search in
                    self?.transferSearchInfo = search
                    dump(self?.transferSearchInfo)
                    self?.searchListView.tableView.reloadData()
                }
            }
            .disposed(by: disposeBag)
        
        // 스터디 변경하기
        searchListView.studyChangedButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.stopQueue()
                print(val)
                let viewControllers : [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController?.popToViewController(viewControllers[1], animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
}

