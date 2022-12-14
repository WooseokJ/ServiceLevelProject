//
//  HomeProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/28.
//

import UIKit
import NMapsMap

protocol viewProtocol {}

protocol HomeProtocol: TransferDataProtocol, APIProtocol, APIQueueProtocol{
    var homeView: HomeView {get}

    func callmyqueueStateRequest()
    func chagedPlotingButton(imageName: String, button: UIButton)

}


extension HomeProtocol where Self: HomeViewController { //where Self: HomeViewController
    

    /// queueState 요청 이게 myqueustate 매소드인데 !!!
    func callmyqueueStateRequest() {
        apiQueue.myqueueStateRequest() { [weak self] data in
            do {
                switch data {
                case .success :
                    self?.chagedPlotingButton(imageName: "antenna.radiowaves.left.and.right.circle.fill", button: self!.homeView.searchBtn)
                    guard try data.get()!.matched == 0 else {
                        let chattingVC = ChattingViewController()
                        self?.transition(chattingVC, transitionStyle: .push)
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
