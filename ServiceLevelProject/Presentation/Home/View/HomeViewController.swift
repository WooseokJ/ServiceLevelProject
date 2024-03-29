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
import Toast


final class HomeViewController: BaseViewController ,HomeProtocol, callSearchProtocol{
    

    static var lng: Double?
    static var lat: Double?
    
    var markers = [NMFMarker]()
    var marker = NMFMarker()
    var transferSearchInfo: Search?
    private var locationManager = CLLocationManager() // 위치
    let circle = NMFCircleOverlay() // 원
    
    let homeView = HomeView()
    override func loadView() {
        super.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        cameraMove(lat: 37.517829 , lng: 126.886270)
        homeView.naverMapView.mapView.addCameraDelegate(delegate: self)
        locationRequest()
        bind()
        refreshIdToken {
            print()
        }
    }
}


extension HomeViewController {
    private func bind() {
        homeView.searchBtn.rx.tap
            .withUnretained(self)
            .bind { (vc,val) in
                vc.callmyqueueStateRequest()
            }.disposed(by: disposeBag)
        
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
                vc.cameraMove(lat: UserDefaults.standard.double(forKey: "lat"), lng: UserDefaults.standard.double(forKey: "lng"))
                self.setpin(lat: UserDefaults.standard.double(forKey: "lat"), lng: UserDefaults.standard.double(forKey: "lng"))
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
            print("현위치:",location.coordinate.latitude, location.coordinate.longitude)
            HomeViewController.lat = location.coordinate.latitude
            HomeViewController.lng = location.coordinate.longitude
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "lat")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "lng")
            
            locationManager.stopUpdatingLocation()
        }
    }
}


extension HomeViewController: NMFMapViewCameraDelegate {
    /// 카메라가 처음 움직일떄 메소드 -> 핀을계속 갱신하고 !!
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        marker.position = homeView.naverMapView.mapView.cameraPosition.target //카메라상 중앙의 좌표
        setpin(lat: marker.position.lat, lng: marker.position.lng)
    }
    /// 카메라가 딱 내가 지정할떄 놓을떄 호출되는 메소드 -> 네트워크 하면되지
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        HomeViewController.lat = marker.position.lat
        HomeViewController.lng = marker.position.lng
        
        callSearch(lat: marker.position.lat, long: marker.position.lng) { [weak self] data in 
            self?.transferSearchInfo = data
        }
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        marker.position = homeView.naverMapView.mapView.cameraPosition.target //카메라상 중앙의 좌표
        setpin(lat: marker.position.lat, lng: marker.position.lng)
    }
    
 
}


extension HomeViewController {
    private func setpin(lat: Double, lng: Double) {  
        marker.position = NMGLatLng(lat: lat , lng: lng)
        marker.iconImage = NMFOverlayImage(image: UIImage(named: "map_marker.png")!)
        marker.mapView = homeView.naverMapView.mapView
        
        // 거리 원
        circle.center = NMGLatLng(lat: lat, lng: lng)
        circle.radius = 700
        circle.mapView = homeView.naverMapView.mapView
        circle.outlineWidth = 1
        circle.outlineColor = UIColor.systemBlue
        circle.fillColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.1)
    }
    private func cameraMove(lat:Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat , lng: lng))
        cameraUpdate.animation = .easeIn
        homeView.naverMapView.mapView.moveCamera(cameraUpdate)
    }
}
