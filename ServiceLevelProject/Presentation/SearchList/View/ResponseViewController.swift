//
//  ResponseViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit
import RxSwift
import RxCocoa

class ResponseViewController: BaseViewController, callSearchProtocol {
    
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
            print(search)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchListView.TableViewSetConstrains()
        tableviewConfigure()
        bind()
//        searchListView.content.text = "아직 받은 요청이 없어요ㅠ"
        
    }
    
    


}

//MARK: 테이블뷰
extension ResponseViewController: UITableViewDelegate, UITableViewDataSource {
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
            }
            .disposed(by: disposeBag)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.25
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isSelect {return UITableView.automaticDimension}
        else {return UIScreen.main.bounds.height * 0.3}
    }
    
    
}
extension ResponseViewController {
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
    }
    
}
