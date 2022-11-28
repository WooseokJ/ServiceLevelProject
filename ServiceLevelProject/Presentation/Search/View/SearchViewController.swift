//
//  SearchViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController, APIProtocol, SearchProtocol {

    var transferSearchInfo: Search?
    
    var nomalList: [String] = []
    var recommendList: [String] = []
    var totalList: [String] = []
    var myfavoriteList: [String] = []
    
    let searchView = SearchView()
    override func loadView() {
        super.view = searchView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewConfigure()
        bind()
        transferSearchInfo?.fromRecommend.forEach{recommendList.append($0)}
        totalList+=recommendList
        transferSearchInfo?.fromQueueDB.forEach {
            $0.studylist.forEach { studyVal in
                totalList.append(studyVal)
            }
        }
        searchBarConfigure()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name:UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name:UIResponder.keyboardWillHideNotification, object: self.view.window)
        
    }
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            searchView.searchButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(keyboardSize.height * 0.75)
                make.leading.equalTo(-10)
                make.trailing.equalTo(10)
                make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            }
        }
    }
    @objc func keyboardHide(notification: NSNotification) {
        searchView.searchButton.snp.remakeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
    }
    
    func bind() {
        searchView.searchButton.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.queuePostRequest(lat: HomeViewController.lat!, long: HomeViewController.lng!, studylist: vc.myfavoriteList)
            }.disposed(by: disposeBag)
            
    }
    

}

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarConfigure() {
        self.navigationItem.titleView = searchView.searchBar
        searchView.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard myfavoriteList.count < 8  else {
            view.makeToast("8개 이상 추가할수없습니다.")
            return
        }
        myfavoriteList.append(searchBar.text!)
        searchView.collectionView.reloadData()
        searchBar.text = ""
    }
    
}


