//
//  AroundSeSacViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/24.
//

import UIKit

class AroundSeSacViewController: BaseViewController {

    let searchListView = SearchListView()
    var isSelect = true
    var testSelect = true
    
    override func loadView() {
        super.view = searchListView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchListView.EmptySetConstrains()
        searchListView.TableViewSetConstrains()
        tableviewConfigure()
//        collectionviewConfigure()
        
        

    }
    

 

}
