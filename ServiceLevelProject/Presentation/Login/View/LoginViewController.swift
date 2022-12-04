//
//  LoginViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/08.
//

import UIKit
import FirebaseAuth
import RxSwift

class LoginViewController: BaseViewController {
    
    var loginView = LoginView()
    
    override func loadView() {
        super.view = loginView
    }
    
    private var verifyID: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.phoneNumberTextField.keyboardType = .numberPad
        loginView.phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:  버튼 탭할떄
        loginView.phoneButton.rx.tap
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind { (vc,val) in
                guard vc.checkMaxLength(textField: vc.loginView.phoneNumberTextField, maxLength: 13) else {
                    print("dsad")
                    return
                }
                // 숫자이외 복붙 방지
                if self.isValidPhone(phone: vc.loginView.phoneNumberTextField.text!) {
                    return
                }

                PhoneAuthProvider.provider().verifyPhoneNumber("+82" + (vc.loginView.phoneNumberTextField.text ?? ""), uiDelegate: nil) { (varification,error) in
                    if error == nil {
                        UserDefaults.standard.set(vc.loginView.phoneNumberTextField.text, forKey: "phoneNumber")
                        let viewController = AuthViewController()
                        viewController.verifyID = varification
                        vc.transition(viewController, transitionStyle: .push)
                    } else {
                        vc.view.endEditing(true)
                        self.view.makeToast("인증번호 과도한 요청")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: textfield의 text가 변경이있을떄
        loginView.phoneNumberTextField.rx.text.orEmpty
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind { (vc,textfield) in
                
                /// 글자수 제한
                guard vc.checkMaxLength(textField: vc.loginView.phoneNumberTextField, maxLength: 13) else {return}
                
                // 숫자이외 복붙 방지
                if self.isValidPhone(phone: textfield) {
                    return
                }
                
                // 글자수에대한 처리
                switch textfield.count {
                    case 0: vc.loginView.textFieldLine.backgroundColor = Grayscale.gray3
                    case 1...12:
                        vc.loginView.phoneButton.backgroundColor = Grayscale.gray6
                    case 13...:
                        vc.loginView.phoneButton.backgroundColor = BrandColor.green
                        return
                    default:
                        vc.loginView.textFieldLine.backgroundColor = BlackWhite.black
                }
                
                //                var str2 = "01041510569"
                //                str2.insert("-", at: str2.index(str2.startIndex, offsetBy: 3))
                var test = vc.loginView.phoneNumberTextField
                switch test.text!.count {
                    case 4:
                        if test.text!.filter{$0 == "-"}.count == 1 {
                            test.deleteBackward()
                        } else {
                            test.text!.insert("-", at: test.text!.index(test.text!.startIndex, offsetBy: 3))
                        }
                        vc.loginView.phoneNumberTextField.text! = test.text!
                        
                    case 9:
                        if test.text!.filter{$0 == "-"}.count == 2 {
                            test.deleteBackward()
                        } else {
                            test.text!.insert("-", at: test.text!.index(test.text!.startIndex, offsetBy: 8))
                        }
                        vc.loginView.phoneNumberTextField.text! = test.text!
                    default:break
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension LoginViewController {
    
    func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        let phoneRegEx = "[0-9]{11}"
        let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: phone)
    }
    
}
