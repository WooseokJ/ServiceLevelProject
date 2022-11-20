//
//  HeaderCollectionView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/20.
//


import UIKit

class HeaderCollectionView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "새싹 타이틀"
        label.textColor = BlackWhite.black
        label.font = AppFont.Title6_R12
        return label
    }()
    
    func configure() {
        self.addSubview(label)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
