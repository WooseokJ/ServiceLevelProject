//
//  HomeProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import UIKit
import NMapsMap


protocol HomeProtocol: APIProtocol {
    var apiQueue: APIQueue {get}
    var homeView: HomeView {get}
    var transferSearchInfo: Search? {get}
    var marker: NMFMarker {get}
    func callmyqueueStateRequest()
    var markers: [NMFMarker] {get set}
    var circle: NMFCircleOverlay {get}

}
extension HomeProtocol where Self: HomeViewController {
    var homeView: HomeView {
        return HomeView()
    }
    var marker: NMFMarker {
        return NMFMarker()
    }
    var markers: [NMFMarker] {
        return [NMFMarker]()
    }
    var circle: NMFCircleOverlay {return NMFCircleOverlay()}
    
    /// queueState 요청 이게 myqueustate 매소드인데 !!!
    func callmyqueueStateRequest() { //여기서 정의해서 채택해서 VC에서는 사용만! VM처럼 쓰는거죠 !! 이걸 프로토콜로 해서 만들어
        self.apiQueue.myqueueStateRequest() { [weak self] statusCode, data in
            switch statusCode {
            case CommonError.success.rawValue: //200
                self?.chagedPlotingButton(imageName: "antenna.radiowaves.left.and.right.circle.fill", button: self!.homeView.searchBtn)

                guard data?.matched == 0 else {
                    print("채팅화면으로 넘어가자!! 아직못함.")
                    return
                }
                let nextVC = SearchListViewController()
                self?.transition(nextVC, transitionStyle: .push)
            case myQueueStateErorr.notRequest.rawValue: //201 요청x
                self?.chagedPlotingButton(imageName: "magnifyingglass.circle.fill", button: self!.homeView.searchBtn)
                let searchVC = SearchViewController()
                
                searchVC.searchList = self?.transferSearchInfo
                
                
                self?.transition(searchVC, transitionStyle: .push)
            case CommonError.tokenErorr.rawValue: //401 토큰만료
                self?.refreshIdToken()
            case CommonError.notUserError.rawValue:
                self?.view.makeToast("미가입회원")
            case CommonError.serverError.rawValue:
                self?.view.makeToast("서버에러")
            case CommonError.clientError.rawValue:
                self?.view.makeToast("클라이언트에러")
            default:
                print("모르는 에러")
            }
        }
    }
    func chagedPlotingButton(imageName: String, button: UIButton)  {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
        let image = UIImage(systemName: imageName , withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
    }
    func callSearch() {
       self.apiQueue.searchRequest(lat: marker.position.lat, long: marker.position.lng) { [self] statusCode, search  in
           transferSearchInfo = search
           guard search!.fromQueueDB.isEmpty else {
               search!.fromQueueDB.forEach {
                   let marker = NMFMarker(position: NMGLatLng(lat: $0.lat, lng: $0.long))
                   switch $0.sesac {
                   case ImageEnum.sesac1.rawValue: marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_1.png")!)
                   case ImageEnum.sesac2.rawValue: marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_2.png")!)
                   case ImageEnum.sesac3.rawValue: marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_3.png")!)
                   case ImageEnum.sesac4.rawValue: marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_4.png")!)
                   case ImageEnum.sesac5.rawValue: marker.iconImage = NMFOverlayImage(image: UIImage(named: "sesac_face_5.png")!)
                   default:break
                   }
                   marker.width = 83.33
                   marker.height = 83.33
                   marker.mapView = homeView.naverMapView.mapView
                   self.markers.append(marker)
               }
               return
           }
       }
   }
    func setpin() {
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
}
