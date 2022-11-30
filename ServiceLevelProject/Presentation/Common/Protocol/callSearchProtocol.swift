//
//  callSearchProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import Foundation
import NMapsMap

protocol callSearchProtocol: TransferDataProtocol, APIProtocol {
    
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void))
}



extension callSearchProtocol where Self: HomeViewController {
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void)) {
        self.apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
            do {
                switch data {
                case .success:
                    let data = try data.get().value!
                    self?.transferSearchInfo = data
                    guard data.fromQueueDB.isEmpty else {
                        data.fromQueueDB.forEach {
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
                            marker.mapView = self?.homeView.naverMapView.mapView
                            self?.markers.append(marker)
                        }
                        return
                    }
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.callSearch(lat: lat, long: long) { _ in
                            self?.view.makeToast("토큰 만료후 재시도")
                        }
                    }
                    
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch{
                print("에러야")
            }
        }
    }
    
}

extension callSearchProtocol where Self: AroundSeSacViewController {
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void)) {
        self.apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
            do {
                switch data {
                case .success:
//                    let AroundVC = AroundSeSacViewController()
//                    AroundVC.searchTest = try data.get().value!
                    completionHandler(try data.get().value!)
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.callSearch(lat: lat, long: long) { _ in
                            self?.view.makeToast("토큰 만료후 재시도")
                        }
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch{print("에러야")}
            }
        
        }
}

extension callSearchProtocol where Self: ResponseViewController {
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void)) {
        self.apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
            do {
                switch data {
                case .success:
                    completionHandler(try data.get().value!)
                case .failure(.notUserError):
                    self?.view.makeToast("미가입 회원")
                case .failure(.tokenErorr):
                    self?.view.makeToast("토큰 만료")
                    self?.refreshIdToken { [weak self] in
                        self?.callSearch(lat: lat, long: long) { _ in
                            self?.view.makeToast("토큰 만료후 재시도")
                        }
                    }
                case .failure(.serverError):
                    self?.view.makeToast("서버 에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트 에러")
                }
            }
            catch{print("에러야")}
            }

        }
}


