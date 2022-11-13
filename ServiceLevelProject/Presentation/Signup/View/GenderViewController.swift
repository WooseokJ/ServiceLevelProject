//
//  GenderViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class GenderViewController: BaseViewController {

    let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText()
        setUI()

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
        
        let manButton: UIButton = {
            let button = UIButton()
            button.setTitle("남자", for: .normal)
            button.setImage(UIImage(named: "man"), for: .normal)
            button.setTitleColor(BlackWhite.black, for: .normal)
            button.semanticContentAttribute = .spatial
            button.tag = 1
            return button
        }()
        
        let womanButton: UIButton = {
            let button = UIButton()
            button.setTitle("여자", for: .normal)
            button.setImage(UIImage(named: "woman.png"), for: .normal)
            button.setTitleColor(BlackWhite.black, for: .normal)
            button.semanticContentAttribute = .playback
            button.tag = 0
            return button
        }()
        
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
        UserInfo.shared.gender = 0
        print(UserInfo.shared.self)
        if UserInfo.shared.fcmtoken != nil {
            api.signup(phoneNumber: UserInfo.shared.phoneNumber!, FCMtoken: UserInfo.shared.fcmtoken!, nick: UserInfo.shared.nick!, birth: UserInfo.shared.birth!, email: UserInfo.shared.email!, gender: UserInfo.shared.gender!) { val in
                print(val)
            }
            
            let vc = MainViewController()
            transition(vc, transitionStyle: .push)
        }

        
    }
}
