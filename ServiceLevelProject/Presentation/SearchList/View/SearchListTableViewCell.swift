//
//  SearchListTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/29.
//

import UIKit


class SearchListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstrains()
    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var moreButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return bt
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func configure() {
        [moreButton,reviewLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        moreButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(0)
            make.trailing.equalTo(-16)
            make.width.equalTo(self.bounds.width * 0.2)
        }
        reviewLabel.snp.remakeConstraints { make in
            make.leading.equalTo(10)
            make.top.equalTo(0)
            make.trailing.equalTo(moreButton.snp.leading).offset(-10)
            make.height.equalTo(30)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(moreButton)
            make.width.equalTo(self)
        }
    }
    
}
