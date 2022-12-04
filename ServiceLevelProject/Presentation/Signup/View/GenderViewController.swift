//
//  GenderViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class GenderViewController: BaseViewController, SignupProtocol {
    
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
        UserDefaults.standard.set(1, forKey: "gender")
        manButton.backgroundColor = BrandColor.whitegreen
    }
    @objc func womanbuttonClicked() {
        manButton.backgroundColor = .clear
        UserDefaults.standard.set(0, forKey: "gender")
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
        signup(phoneNumber: UserDefaults.standard.string(forKey: "phoneNumber")!, FCMtoken: UserDefaults.standard.string(forKey: "fcmtoken")!, nick: UserDefaults.standard.string(forKey: "nick")!, birth: UserDefaults.standard.string(forKey: "birth")!, email: UserDefaults.standard.string(forKey: "email")!, gender: UserDefaults.standard.integer(forKey: "gender"))
        
    }
}
