//
//  BaseView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/07.
//


import UIKit

class BaseView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {}
    func setConstrains() {}
    
}
