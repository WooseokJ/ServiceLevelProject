//
//  BirthViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class BirthViewController: BaseViewController {
    
    var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    
    var monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  1"
        return textField
    }()
    
    var monthLine: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    
    var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    
    
    var dayTextFeild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  1"
        return textField
    }()
    var dayLine: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    
    let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText()
        remake()
        addLabel()
        loginView.phoneButton.addTarget(self, action: #selector(birthButtonClicked), for: .touchUpInside)

    }
    

    
    func newText() {
        loginView.phoneNumberTextField.placeholder = "  1990"
        loginView.phoneNumberTextField.textAlignment = .left
        loginView.phoneTextLabel.text = "생년월일을 알려주세요"
        loginView.phoneButton.setTitle("다음", for: .normal)

    }
    
    func remake() {
        loginView.phoneNumberTextField.snp.remakeConstraints { make in
            make.leading.equalTo(28)
            make.height.equalTo(loginView.phoneButton.snp.height)
            make.top.equalTo(loginView.phoneTextLabel.snp.bottom).offset(30)
            make.width.equalTo(80)
        }
        loginView.textFieldLine.snp.remakeConstraints { make in
            make.width.equalTo(loginView.phoneNumberTextField.snp.width)
            make.height.equalTo(1)
            make.leading.equalTo(loginView.phoneNumberTextField.snp.leading)
            make.top.equalTo(loginView.phoneNumberTextField.snp.bottom).offset(2)
        }
        
    }
    
    func addLabel() {
       
        
        [yearLabel,monthTextField,monthLabel,dayTextFeild,dayLabel,monthLine,dayLine].forEach {
            self.view.addSubview($0)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalTo(loginView.phoneNumberTextField.snp.trailing).offset(5)
            make.width.equalTo(28)
            make.height.equalTo(loginView.phoneNumberTextField.snp.height)
            make.top.equalTo(loginView.phoneNumberTextField.snp.top)
        }
        
        
        monthTextField.snp.makeConstraints { make in
            make.leading.equalTo(yearLabel.snp.trailing).offset(5)
            make.width.equalTo(loginView.phoneNumberTextField.snp.width)
            make.height.equalTo(loginView.phoneNumberTextField.snp.height)
            make.top.equalTo(loginView.phoneNumberTextField.snp.top)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.leading.equalTo(monthTextField.snp.trailing).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(monthTextField.snp.height)
            make.top.equalTo(monthTextField.snp.top)
        }
        
        monthLine.snp.makeConstraints { make in
            make.width.equalTo(monthTextField.snp.width)
            make.height.equalTo(1)
            make.leading.equalTo(monthTextField.snp.leading)
            make.top.equalTo(monthTextField.snp.bottom).offset(2)
        }
        
        
        dayLine.snp.makeConstraints { make in
            make.width.equalTo(dayTextFeild.snp.width)
            make.height.equalTo(1)
            make.leading.equalTo(dayTextFeild.snp.leading)
            make.top.equalTo(dayTextFeild.snp.bottom).offset(2)
        }
        
        dayTextFeild.snp.makeConstraints { make in
            make.leading.equalTo(monthLabel.snp.trailing).offset(5)
            make.width.equalTo(loginView.phoneNumberTextField.snp.width)
            make.height.equalTo(loginView.phoneNumberTextField.snp.height)
            make.top.equalTo(loginView.phoneNumberTextField.snp.top)
        }
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(dayTextFeild.snp.trailing).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(monthTextField.snp.height)
            make.top.equalTo(monthTextField.snp.top)
        }
        
        
        
    }
    
    @objc func birthButtonClicked() {
        UserInfo.shared.birth = "\(loginView.phoneNumberTextField.text!)-\(monthTextField.text!)-\(dayTextFeild.text!)T09:23:44.054Z"
        let vc = EmailViewController()
        transition(vc, transitionStyle: .push)
    }

}
