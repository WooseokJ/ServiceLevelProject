//
//  SearchViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import UIKit

class SearchViewController: BaseViewController {

    let searchView = SearchView()
    override func loadView() {
        super.view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        self.navigationItem.titleView = searchView.searchBar
        
    }
    
//    @objc func keyboardWillShow(_ sender: Notification) {
//        searchView.searchButton.frame.origin.y = -0.01
//        }
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.view.endEditing(true)
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.view.endEditing(true)
//    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
