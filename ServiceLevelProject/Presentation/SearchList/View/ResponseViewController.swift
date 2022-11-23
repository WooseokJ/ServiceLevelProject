//
//  ResponseViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit

class ResponseViewController: UIViewController {
    
    var searchListView = SearchListView()
    override func loadView() {
        super.view = searchListView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchListView.content.text = "아직 받은 요청이 없어요ㅠ"
    }
    
    


}
