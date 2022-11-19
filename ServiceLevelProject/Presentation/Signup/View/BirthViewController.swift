//
//  BirthViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/14.
//

import UIKit

class BirthViewController: BaseViewController {
  
    var list = ["1", "2", "3"]
    var list2 = ["3", "4", "5"]
    var list3 = ["아", "가", "야"]
    
    lazy var pickerView: UIPickerView = {
        let piker = UIPickerView()
        piker.delegate = self
        piker.dataSource = self
        return piker
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    
    lazy var monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  1"
        return textField
    }()
    
    lazy var monthLine: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    
    
    lazy var dayTextFeild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  1"
        return textField
    }()
    lazy var dayLine: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    
    private let loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newText()
        remake()
        addLabel()
        loginView.phoneButton.addTarget(self, action: #selector(birthButtonClicked), for: .touchUpInside)
        configToolbar()
        loginView.phoneNumberTextField.inputView = pickerView
        monthTextField.inputView = pickerView
        dayTextFeild.inputView = pickerView
        
        
        
    }
    @objc func pikerExit() {
        // spicker와 같은 뷰 닫는함수
        self.view.endEditing(true)
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
extension BirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //피커 몇개고를거냐?
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:     return birthDay.year.list.count
            case 1: return birthDay.month.list.count
            case 2: return birthDay.day.list.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return birthDay.year.list[row]
        case 1: return birthDay.month.list[row]
        case 2: return birthDay.day.list[row]
        default:
            return ""
        }
    }
    
    /// 피커뷰에서 선택된 행을 처리할 수 있는 메서드
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
           switch component {
           case 0:
               loginView.phoneNumberTextField.text = birthDay.year.list[row]
           case 1:
               monthTextField.text = birthDay.month.list[row]
           case 2:
               dayTextFeild.text = birthDay.day.list[row]
           default:
               break
           }
       }
    
   
    //MARK: 피커뷰 위한 툴바
    func configToolbar() { // 4
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.backgroundColor = .black
        toolBar.sizeToFit()
        
//        let row = pickerView.selectedRow(inComponent: 0)
//        pickerView.selectRow(row, inComponent: 0, animated: false)
//        loginView.phoneNumberTextField.resignFirstResponder()


        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        
        toolBar.setItems([flexibleSpace], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        loginView.phoneNumberTextField.inputAccessoryView = toolBar
    }
    
    
    
    
}

