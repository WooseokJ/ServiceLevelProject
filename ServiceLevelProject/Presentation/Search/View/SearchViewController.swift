//
//  SearchViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    let searchView = SearchView()
    override func loadView() {
        super.view = searchView
    }
    
    var searchList: Search?
    var aroundList: [String] = []
    var myfavoriteList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewConfigure()
        bind()
        
        searchList?.fromRecommend.forEach { aroundList.append($0) }
        
        self.navigationItem.titleView = searchView.searchBar
        searchView.searchBar.delegate = self
        
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
                let searchListVC = SearchListViewController()
                vc.transition(searchListVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        myfavoriteList.append(searchBar.text!)
        searchView.collectionView.reloadData()
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
}
