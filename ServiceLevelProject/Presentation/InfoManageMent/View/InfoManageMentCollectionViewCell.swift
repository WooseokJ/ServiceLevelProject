//
//  InfoManageMentCollectionViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/20.
//

import UIKit



class InfoManageMentCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: 연결
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var itemButton: UIButton = {
        let bt = UIButton()
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor =  Grayscale.gray4.cgColor
        return bt
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    func configure() {
        self.contentView.addSubview(itemButton)
        self.contentView.addSubview(reviewLabel)
    }
    
    func setConstrains() {
        itemButton.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    
}
