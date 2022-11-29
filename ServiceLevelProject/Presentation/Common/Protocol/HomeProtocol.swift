//
//  HomeProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import UIKit
import NMapsMap

protocol viewProtocol {}

protocol HomeProtocol: TransferDataProtocol, APIProtocol{
    var homeView: HomeView {get}
//    var circle: NMFCircleOverlay {get}
    func callmyqueueStateRequest()
    func chagedPlotingButton(imageName: String, button: UIButton)
//    var marker: NMFMarker {get}
//    var markers: [NMFMarker] {get set}
}


extension HomeProtocol where Self: HomeViewController { //where Self: HomeViewController
    
    
//    var homeView: HomeView {
//        return HomeView()
//    }
//
//    var circle: NMFCircleOverlay {
//        return NMFCircleOverlay()
//    }
    
    
    /// queueState 요청 이게 myqueustate 매소드인데 !!!
    func callmyqueueStateRequest() { //여기서 정의해서 채택해서 VC에서는 사용만! VM처럼 쓰는거죠 !! 이걸 프로토콜로 해서 만들어
        self.apiQueue.myqueueStateRequest() { [weak self] data in
            do {
                switch data {
                case .success :
                    self?.chagedPlotingButton(imageName: "antenna.radiowaves.left.and.right.circle.fill", button: self!.homeView.searchBtn)
                    guard try data.get()!.matched == 0 else {
                        print("채팅화면으로 넘어가자!! 아직못함.")
                        return
                    }
                    
                    let nextVC = SearchListViewController()
                    self?.transition(nextVC, transitionStyle: .push)
                case .failure(.notRequest):
                    self?.chagedPlotingButton(imageName: "magnifyingglass.circle.fill", button: self!.homeView.searchBtn)
                    let searchVC = SearchViewController()
                    searchVC.transferSearchInfo = self?.transferSearchInfo
                    self?.transition(searchVC, transitionStyle: .push)
                case .failure(.tokenErorr):
                    self?.refreshIdToken {
                        self?.callmyqueueStateRequest()
                    }
                case .failure(.notUserError):
                    self?.view.makeToast("미가입회원")
                case .failure(.serverError):
                    self?.view.makeToast("서버에러")
                case .failure(.clientError):
                    self?.view.makeToast("클라이언트에러")
                default:
                    print("모르는 에러")
                }
            }
            catch {
                print("알수없는오류")
            }
           
        }
    }
    func chagedPlotingButton(imageName: String, button: UIButton)  {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
        let image = UIImage(systemName: imageName , withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
    }
   
    
    
}
