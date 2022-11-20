//
//  ViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/07.
//

import UIKit
import NMapsMap
import CoreLocation
import SnapKit

class HomeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
        mapView.snp.makeConstraints { $0.edges.equalTo(0)}
    }
    
}
