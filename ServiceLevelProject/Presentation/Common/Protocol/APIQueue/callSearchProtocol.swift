//
//  callSearchProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import Foundation
import NMapsMap

protocol callSearchProtocol: TransferDataProtocol, APIProtocol, APIQueueProtocol {
    
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void))
}



extension callSearchProtocol where Self: HomeViewController {
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void)) {
        apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
            do {
                switch data {
                case .success:
                    print(data)
                    let data = try data.get().value!
                    completionHandler(data)

                    guard data.fromQueueDB.isEmpty else {
                        data.fromQueueDB.forEach {
                            let marker = NMFMarker(position: NMGLatLng(lat: $0.lat, lng: $0.long))
                            let sesacpin = ImageEnum(rawValue: $0.sesac)
                            marker.iconImage = NMFOverlayImage(image: UIImage(named: sesacpin!.list)!)
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

extension callSearchProtocol where Self: AcceptViewController {
    func callSearch(lat: Double, long: Double, completionHandler: @escaping ((Search?) -> Void)) {
        apiQueue.searchRequest(lat: lat, long: long) { [weak self]  data  in
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


