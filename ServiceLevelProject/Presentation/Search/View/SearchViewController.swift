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
    var apiQueue = APIQueue()
    
    var nomalList: [String] = []
    var recommendList: [String] = []
    var totalList: [String] = []
    var myfavoriteList: [String] = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backButtonTitle = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewConfigure()
        bind()
        searchList?.fromRecommend.forEach{ recommend in
            recommendList.append(recommend)
        }
        
        totalList+=recommendList
        
        searchList?.fromQueueDB.forEach {
            $0.studylist.forEach { studyVal in
                print(studyVal)
                totalList.append(studyVal)
            }
        }
        
        
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
            .bind { [weak self] (val) in
                self?.queuePostRequest()
            }.disposed(by: disposeBag)
    }
    
    func queuePostRequest() {
        self.apiQueue.queueRequest(lat: HomeViewController.lat!, long: HomeViewController.lng!, studylist: self.myfavoriteList) { [self] tt  in
            print(tt)
            switch tt {
            case .success(_):
                print()
            case .failure(.success):
                print()
            case .failure(.tokenErorr):
                print()
            case .failure(.notUserError):
                print()
            case .failure(.serverError):
                print()
            case .failure(.clientError):
                print()
            }
            
//            switch statusCode {
//            case CommonError.success.rawValue:
//                self.apiQueue.searchRequest(lat: HomeViewController.lat!, long: HomeViewController.lng!) { statusCode, search in
//                    let searchListVC = SearchListViewController()
//                    searchListVC.searchInfo = search
//                    self.transition(searchListVC, transitionStyle: .push)
//                }
//            default:
//                self.view.makeToast("선택해라!! ")
//                break
//            }
            
        }
    }
    
    
    
    
}

extension SearchViewController : UISearchBarDelegate {
    
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


