//
//  LoginViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/08.
//

import UIKit
import FirebaseAuth

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
            .withUnretained(self)
            .bind { (vc,val) in
                if vc.checkMaxLength(textField: vc.loginView.phoneNumberTextField, maxLength: 13) {return}
                
                PhoneAuthProvider.provider().verifyPhoneNumber("+82" + (vc.loginView.phoneNumberTextField.text ?? ""), uiDelegate: nil) { (varification,error) in
                    if error == nil {
                        vc.verifyID = varification
                        print("verify:",vc.verifyID)
                        
                        UserInfo.shared.phoneNumber = vc.loginView.phoneNumberTextField.text // 폰번호입력
                        
                        let vc = AuthViewController()
                        vc.verifyID = varification
                        vc.transition(vc, transitionStyle: .push)
                    } else {
                        print("넌 오류야 ")
                    }
                }
            }
            .disposed(by: disposeBag)
        
        //MARK: textfield의 text가 변경이있을떄
        loginView.phoneNumberTextField.rx.text.orEmpty
            .withUnretained(self)
            .bind { (vc,textfield) in
//                var phoneText = loginView.phoneNumberTextField
                /// 글자수 제한
                guard vc.checkMaxLength(textField: vc.loginView.phoneNumberTextField, maxLength: 13) else {return}
                
                // 숫자이외 복붙 방지
                if vc.isValidPhone(phone: textfield) {
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
//                phoneText.text.insert("-", at: phoneText.index(phoneText.startIndex,offsetBy: 4))
//                phoneText.text.insert("-", at: phoneText.index(phoneText.startIndex,offsetBy: -2))
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
