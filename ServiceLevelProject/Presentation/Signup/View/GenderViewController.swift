//
//  GenderViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class GenderViewController: BaseViewController {
    
    lazy var manButton: UIButton = {
        let button = UIButton()
        button.setTitle("남자", for: .normal)
        button.setImage(UIImage(named: "man"), for: .normal)
        button.setTitleColor(BlackWhite.black, for: .normal)
        button.semanticContentAttribute = .spatial
        return button
    }()
    
    lazy var womanButton: UIButton = {
        let button = UIButton()
        button.setTitle("여자", for: .normal)
        button.setImage(UIImage(named: "woman.png"), for: .normal)
        button.setTitleColor(BlackWhite.black, for: .normal)
        button.semanticContentAttribute = .playback
        return button
    }()
    let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText()
        setUI()
        manButton.addTarget(self, action: #selector(manbuttonClicked), for: .touchUpInside)
        womanButton.addTarget(self, action: #selector(womanbuttonClicked), for: .touchUpInside)
    }
    
    @objc func manbuttonClicked() {
        womanButton.backgroundColor = .clear
        UserInfo.shared.gender = 1
        manButton.backgroundColor = BrandColor.whitegreen
    }
    @objc func womanbuttonClicked() {
        manButton.backgroundColor = .clear
        UserInfo.shared.gender = 1
        womanButton.backgroundColor = BrandColor.whitegreen
    }
    
    func newText() {
        loginView.phoneButton.setTitle("다음", for: .normal)
        loginView.phoneTextLabel.text = "성별을 선택해 주세요"
        loginView.phoneNumberTextField.snp.remakeConstraints { make in
            make.width.height.equalTo(0)
            make.bottom.equalTo(100)
        }
        loginView.phoneButton.addTarget(self, action: #selector(genderButtonClicked), for: .touchUpInside)
        
    }
    func setUI() {
        [manButton,womanButton].forEach {
            self.view.addSubview($0)
        }
        
        manButton.snp.makeConstraints { make in
            make.top.equalTo(loginView.phoneTextLabel.snp.bottom).offset(30)
            make.height.equalTo(120)
            make.leading.equalTo(16)
            make.width.equalTo(180)
        }
        
        womanButton.snp.makeConstraints { make in
            make.top.equalTo(manButton.snp.top)
            make.height.equalTo(manButton.snp.height)
            make.leading.equalTo(manButton.snp.trailing).offset(10)
            make.width.equalTo(manButton.snp.width)
        }
        loginView.phoneButton.snp.remakeConstraints { make in
            make.top.equalTo(womanButton.snp.bottom).offset(72)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(48)
        }
    }

    @objc func genderButtonClicked() {
        guard UserInfo.shared.gender != nil else {
            self.view.makeToast("성별을 선택해 주세요")
            return
        }
        guard UserInfo.shared.phoneNumber! != nil else {return}
        guard UserInfo.shared.fcmtoken! != nil else {return}
        guard UserInfo.shared.nick! != nil else {return}
        guard UserInfo.shared.birth! != nil else {return}
        guard UserInfo.shared.email! != nil else {return}
        guard UserInfo.shared.gender! != nil else {return}
        signupRequest()
       
    }
    
    func signupRequest() {
        api.signup(phoneNumber: UserInfo.shared.phoneNumber!, FCMtoken: UserInfo.shared.fcmtoken!, nick: UserInfo.shared.nick!, birth: UserInfo.shared.birth!, email: UserInfo.shared.email!, gender: UserInfo.shared.gender!) { [self] val , statusCode in 
            if val && statusCode == 200 {
                let vc = MainViewController()
                transition(vc, transitionStyle: .push)
            } else {
                switch statusCode {
                case 201:
                    view.makeToast("이미 가입한 유저")
                case 202:
                    view.makeToast("사용할수없는 이메일")
                case 401:
                    view.makeToast("토큰 만료")
                    signupRequest()
                case 500:
                    view.makeToast("서버 오류")
                case 501:
                    view.makeToast("클라이언트 오류")
                default:
                    view.makeToast("알수없는 오류")
                }
            }
        }
    }
}
