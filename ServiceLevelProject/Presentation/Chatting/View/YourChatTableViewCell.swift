//
//  YourChatTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit

class YourChatTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let yourChatLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.layer.cornerRadius = 8
        label.layer.borderWidth = 1
        label.layer.borderColor = BlackWhite.black.cgColor
        label.numberOfLines = 0
        return label
    }()
    
    
    
    func configure() {
        [yourChatLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        yourChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.height.equalTo(self.snp.height)
            make.width.equalTo(200)
            make.top.equalTo(self.snp.top)
        }
    }

}
