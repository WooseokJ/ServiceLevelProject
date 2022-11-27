//
//  BaseViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/07.
//

import UIKit
import RxSwift
import RxCocoa
import Toast
import FirebaseAuth

class BaseViewController: UIViewController {
    let baseView = BaseView()
    
    override func loadView() {
        self.view = baseView
    }
        
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BlackWhite.white
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) -> Bool {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
            return false
        }
        return true
    }
}

extension BaseViewController: UITextFieldDelegate {
    // 키보드 여백 누를떄
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
