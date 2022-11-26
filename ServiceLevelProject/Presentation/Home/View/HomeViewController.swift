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

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    override func loadView() {
        super.view = homeView
    }
    
    static var lng: Double?
    static var lat: Double?
    
    private let marker = NMFMarker()
    var markers = [NMFMarker]() // 마커 모음.
    private var locationManager = CLLocationManager() // 위치
    private let circle = NMFCircleOverlay() // 원
    private var transferSearchInfo: Search?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = ""
        callSearch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.naverMapView.mapView.addCameraDelegate(delegate: self)
        locationRequest()
        bind() //이게 viewWillAppear에 있으면 여러번호출
        self.refreshIdToken()
    }
}


extension HomeViewController: APIProtocol, ButtonProtocol {
    
    
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
                let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: HomeViewController.lat ?? 0 , lng: HomeViewController.lng ?? 0 ))
                cameraUpdate.animation = .easeIn
                vc.homeView.naverMapView.mapView.moveCamera(cameraUpdate)
                
                vc.callSearch()
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
            locationManager.stopUpdatingLocation()
        }
    }
}


extension HomeViewController: NMFMapViewCameraDelegate {
    // 카메라가 처음 움직일떄 메소드 -> 핀을계속 갱신하고 !!
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        setpin()
    }
    // 카메라가 딱 내가 지정할떄 놓을떄 호출되는 메소드 -> 네트워크 하면되지
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        callSearch()
    }
    
    private func setpin() {
        marker.position = homeView.naverMapView.mapView.cameraPosition.target //카메라상 중앙의 좌표
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
    private func callSearch() {
        self.apiQueue.searchRequest(lat: marker.position.lat, long: marker.position.lng) { [self] search  in
            print(search?.fromRecommend)
            print(search?.fromQueueDB.count)
            print(search?.fromQueueDBRequested)
            
            self.transferSearchInfo = search
            guard search!.fromQueueDB.isEmpty else {
                search!.fromQueueDB.forEach {
                    let marker = NMFMarker(position: NMGLatLng(lat: $0.lat, lng: $0.long))
                    marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_3.png")!)
                    marker.mapView = homeView.naverMapView.mapView
                    markers.append(marker)
                }
                return
            }
        }
    }
    private func callmyqueueStateRequest() {
        apiQueue.myqueueStateRequest(idtoken: UserDefaults.standard.string(forKey: "token")!) { [self] statusCode, data in
            switch statusCode {
            case CommonError.success.rawValue: //200
                chagedPlotingButton(imageName: "antenna.radiowaves.left.and.right.circle.fill", button: homeView.searchBtn)
                guard data?.matched == 0 else {
                    print("채팅화면으로 넘어가자!! 아직못함.")
                    return
                }
                let nextVC = SearchListViewController()
                transition(nextVC, transitionStyle: .push)
                
            case myQueueStateErorr.notRequest.rawValue: //201 요청x
                chagedPlotingButton(imageName: "magnifyingglass.circle.fill", button: homeView.searchBtn)
                let searchVC = SearchViewController()
                searchVC.searchList = transferSearchInfo
                transition(searchVC, transitionStyle: .push)
            case CommonError.tokenErorr.rawValue: //401 토큰만료
                refreshIdToken()
            case CommonError.notUserError.rawValue:
                print("미가입회원")
            case CommonError.serverError.rawValue:
                print("서버에러")
            case CommonError.clientError.rawValue:
                print("클라이언트에러")
            default:
                print("모르는 에러")
            }
            print("123t")
        }
    }
}

