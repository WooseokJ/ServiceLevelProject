//
//  AuthView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/08.
//

import SnapKit
import UIKit

enum Auth: String {
    case textLabel = "인증번호가 문자로 전송되었어요"
    case textFieldPlaceholder = "인증번호 입력"
    case textButton = "인증 문자 받기"
    case textReDirectButton = "재전송"
}

class AuthView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var authTextLabel: UILabel = { // 휴대폰 소개 라벨
        let label = UILabel()
        label.text = "\(Auth.textLabel.rawValue)"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    lazy var authTextField: UITextField = { // 휴대폰번호
        let textField = UITextField()
        textField.placeholder = "\(Auth.textFieldPlaceholder.rawValue)"
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    lazy var authFieldLine: UIView = { // 텍스트 필드 라인
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    
    lazy var authTimerLabel: UILabel = {
        let label = UILabel()
        label.text = "05:00"
        label.font = AppFont.Title3_M14
        return label
    }()
    
    lazy var authredirectButton: UIButton = { //재전송 버튼
        let button = UIButton()
        button.backgroundColor = BrandColor.green
        button.setTitle(Auth.textReDirectButton.rawValue, for: .normal)
        return button
    }()
    
    lazy var authButton: UIButton = { // 인증문자 버튼
        let button = UIButton()
        button.setTitle("\(Auth.textButton.rawValue)", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = Grayscale.gray6
        return button
    }()
    
    
    override func configure() {
        [authTextLabel,authTextField, authTimerLabel,
         authredirectButton,authFieldLine,
         authFieldLine,authButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        
        authTextLabel.snp.makeConstraints { make in
            make.top.equalTo(168)
            make.leading.equalTo(57.5)
            make.trailing.equalTo(-57.5)
            make.height.equalTo(32)
        }
        
        authTextField.snp.makeConstraints { make in
            make.top.equalTo(authTextLabel.snp.bottom).offset(110)
            make.leading.equalTo(28)
            make.width.equalTo(81)
            make.height.equalTo(22)
        }
        
        authTimerLabel.snp.makeConstraints { make in
            make.leading.equalTo(authTextField.snp.trailing).offset(121)
            make.top.equalTo(authTextLabel.snp.bottom).offset(110)
            make.width.equalTo(37)
            make.height.equalTo(22.4)
        }
        
 
        authFieldLine.snp.makeConstraints { make in
            make.top.equalTo(authTextField.snp.bottom).offset(12)
            make.leading.equalTo(12)
            make.trailing.equalTo(96)
            make.height.equalTo(1)
        }
        
        authredirectButton.snp.makeConstraints { make in
            make.top.equalTo(authTextLabel.snp.bottom).offset(103)
            make.trailing.equalTo(-16)
            make.width.equalTo(72)
            make.height.equalTo(40)
            make.leading.equalTo(authTimerLabel.snp.trailing).offset(20)
            
        }
        
        authButton.snp.makeConstraints { make in
            make.top.equalTo(authFieldLine.snp.bottom).offset(72)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(48)
        }
        
        
    }
    
    
}
