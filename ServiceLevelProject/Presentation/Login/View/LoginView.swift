//
//  LoginView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/08.
//

import SnapKit
import UIKit


class LoginView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var phoneNumberTextField: UITextField = { // 휴대폰번호
        let textField = UITextField()
        textField.placeholder = "\(login.textFieldPlaceholder.rawValue)"
        textField.font = .systemFont(ofSize: 14)
//        textField.keyboardType = .numberPad
        return textField
    }()
    lazy var phoneTextLabel: UILabel = { // 휴대폰 소개 라벨
        let label = UILabel()
        label.text = "\(login.textLabel.rawValue)"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    lazy var textFieldLine: UIView = { // 텍스트 필드 라인
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    lazy var phoneButton: UIButton = { // 인증문자 버튼
        let button = UIButton()
        button.setTitle("\(login.textButton.rawValue)", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = Grayscale.gray6
        return button
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    override func configure() {
        [phoneTextLabel,phoneNumberTextField,textFieldLine,phoneButton,subTitle].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        
        phoneTextLabel.snp.makeConstraints { make in
            make.top.equalTo(169)
            make.leading.equalTo(73)
            make.trailing.equalTo(-74)
            make.height.equalTo(64)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextLabel.snp.bottom).offset(77)
            make.leading.equalTo(28)
            make.height.equalTo(22)
            make.width.equalTo(179)
        }
        
        textFieldLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(12)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        phoneButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldLine.snp.bottom).offset(85)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(48)
        }
        
        
    }
    
    
}
