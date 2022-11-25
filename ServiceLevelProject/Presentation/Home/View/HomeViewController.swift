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

final class HomeViewController: BaseViewController {
    
    let homeView = HomeView()
    override func loadView() {
        super.view = homeView
    }
    
    static var lng: Double?
    static var lat: Double?
    
    private let marker = NMFMarker()
    private var locationManager = CLLocationManager() // 위치
    private let circle = NMFCircleOverlay() // 원
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationRequest()
        navigationItem.backButtonTitle = ""
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.naverMapView.mapView.addCameraDelegate(delegate: self)
    }
    
   
}

extension HomeViewController: APIProtocol {
    private func bind() {
        homeView.searchBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
                let image = UIImage(systemName: "antenna.radiowaves.left.and.right.circle.fill", withConfiguration: imageConfig)
                vc.homeView.searchBtn.setImage(image, for: .normal)
                self.refreshIdToken()
                self.apiQueue.myqueueStateRequest(idtoken: UserDefaults.standard.string(forKey: "token")!) { bool, statusCode in
                    print(bool,statusCode)
                }
//                self.apiQueue.searchRequest(lat: HomeViewController.lat!, long: HomeViewController.lng!) { search in
                    let searchVC = SearchViewController()
                    vc.transition(searchVC, transitionStyle: .push)
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
        homeView.locationBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.homeView.locationBtn.setTitle("complass", for: UIControl.State.selected)
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: HomeViewController.lat ?? 0 , lng: HomeViewController.lng ?? 0 ))
                cameraUpdate.animation = .easeIn
                vc.homeView.naverMapView.mapView.moveCamera(cameraUpdate)
            }
            .disposed(by: disposeBag)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    private func locationRequest() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                print("위치 서비스 On 상태")
                self.locationManager.startUpdatingLocation()
            } else {
                print("위치 서비스 Off 상태")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            HomeViewController.lat = location.coordinate.latitude
            HomeViewController.lng = location.coordinate.longitude
            setpin()
        }
        locationManager.stopUpdatingLocation() // stopUpdatingHeading 이랑 주의
    }
    


}


extension HomeViewController: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        setpin()
    }
    
    private func setpin() {
        marker.position = homeView.naverMapView.mapView.cameraPosition.target
        marker.position = NMGLatLng(lat: marker.position.lat, lng: marker.position.lng)
        marker.iconImage = NMFOverlayImage(image: UIImage(named: "map_marker.png")!)
        marker.mapView = homeView.naverMapView.mapView
        
        // 거리 원
        circle.center = NMGLatLng(lat: marker.position.lat, lng: marker.position.lng)
        circle.radius = 700
        circle.mapView = homeView.naverMapView.mapView
        circle.outlineWidth = 1
        circle.outlineColor = UIColor.systemBlue
        circle.fillColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.1)
    }
}
