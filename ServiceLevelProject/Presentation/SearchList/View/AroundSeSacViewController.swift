//
//  AroundSeSacViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit

class AroundSeSacViewController: BaseViewController, callSearchProtocol {

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
            print(search)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchListView.EmptySetConstrains()
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchListTableViewCell.reuseIdentifier, for: indexPath) as! SearchListTableViewCell
//        if testSelect {
//            searchListView.collectionview.snp.remakeConstraints{$0.width.height.equalTo(0)}
//        }
//        else {
//            searchListView.collectionViewSetConstrains(cell: cell)
//        }
        cell.backgroundColor = .darkGray
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
        headerView.requestButtonConstrains()
        
        
        headerView.requestButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.requestAcceptSetConstrains()
                // 버튼클릭시 컨스트레인트 그려줌
            }
            .disposed(by: disposeBag)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isSelect {
            return UITableView.automaticDimension
        } else {
            return UIScreen.main.bounds.height * 0.3
        }
    }
    
    
}

extension AroundSeSacViewController {
    private func bind() {
        searchListView.cancelButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.searchListView.cancelButtonClicked()
                vc.searchListView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        searchListView.okButton
            .rx
            .tap
            .withUnretained(self)
            .bind { (vc,val) in
                print("dsad")
                
            }
            .disposed(by: disposeBag)
    }
    
    
    
}
