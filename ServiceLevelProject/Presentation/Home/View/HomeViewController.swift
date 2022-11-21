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

final class HomeViewController: BaseViewController, NMFMapViewCameraDelegate {
    
    let homeView = HomeView()
    override func loadView() {
        super.view = homeView
    }
    private var lng: Double?
    private var lat: Double?
    
    private let marker = NMFMarker()
    private var locationManager = CLLocationManager() // 위치
    private let circle = NMFCircleOverlay() // 원
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetLocationBtn()
        navigationItem.backButtonTitle = ""
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        homeView.naverMapView.mapView.addCameraDelegate(delegate: self)
        bind()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation()
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }
}

extension HomeViewController {
    private func bind() {
        homeView.searchBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                let searchVC = SearchViewController()
                self.navigationController?.pushViewController(searchVC, animated: true)

//                vc.transition(searchVC, transitionStyle: .push)
            }
            .disposed(by: disposeBag)
        
        homeView.allBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.homeView.allBtn.backgroundColor = BrandColor.green
                vc.homeView.allBtn.setTitleColor(BlackWhite.white, for: .normal)
                vc.homeView.womanFilterBtn.backgroundColor = BlackWhite.white
                vc.homeView.womanFilterBtn.setTitleColor(BlackWhite.black, for: .normal)
                vc.homeView.manFilterBtn.backgroundColor = BlackWhite.white
                vc.homeView.manFilterBtn.setTitleColor(BlackWhite.black, for: .normal)

            }
            .disposed(by: disposeBag)
        
        homeView.manFilterBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.homeView.manFilterBtn.backgroundColor = BrandColor.green
                vc.homeView.manFilterBtn.setTitleColor(BlackWhite.white, for: .normal)
                vc.homeView.womanFilterBtn.backgroundColor = BlackWhite.white
                vc.homeView.womanFilterBtn.setTitleColor(BlackWhite.black, for: .normal)
                vc.homeView.allBtn.backgroundColor = BlackWhite.white
                vc.homeView.allBtn.setTitleColor(BlackWhite.black, for: .normal)

            }
            .disposed(by: disposeBag)
        
        homeView.womanFilterBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.homeView.womanFilterBtn.backgroundColor = BrandColor.green
                vc.homeView.womanFilterBtn.setTitleColor(BlackWhite.white, for: .normal)
                vc.homeView.manFilterBtn.backgroundColor = BlackWhite.white
                vc.homeView.manFilterBtn.setTitleColor(BlackWhite.black, for: .normal)
                vc.homeView.allBtn.backgroundColor = BlackWhite.white
                vc.homeView.allBtn.setTitleColor(BlackWhite.black, for: .normal)

            }
            .disposed(by: disposeBag)
        
    }
    
    func SetLocationBtn() {
        homeView.locationBtn.setTitle("complass", for: UIControl.State.selected)
        homeView.locationBtn.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
    }
    @objc func locationTapped(_ sender: UIButton) {
        // 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0 , lng: lng ?? 0 ))
        cameraUpdate.animation = .easeIn
        homeView.naverMapView.mapView.moveCamera(cameraUpdate)
    }
}


extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
            
            marker.position = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            marker.mapView = homeView.naverMapView.mapView
            marker.iconImage = NMFOverlayImage(image: UIImage(named: "map_marker.png")!)
            
            
            // 거리 원
            circle.center = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            circle.radius = 700
            circle.mapView = homeView.naverMapView.mapView
            circle.outlineWidth = 1
            circle.outlineColor = UIColor.systemBlue
            circle.fillColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.1)

        }
        // 위치 업데이트 멈춰 (실시간성이 중요한거는 매번쓰고, 중요하지않은건 원하는 시점에 써라)
        locationManager.stopUpdatingLocation() // stopUpdatingHeading 이랑 주의
    }
}
