//
//  ChattingTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit

class MychatTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let myChatLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        return label
    }()
    
    
    
    func configure() {
        [myChatLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        myChatLabel.snp.makeConstraints { make in
            make.leading.equalTo(30)
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.top.equalTo(self.snp.top)
        }
    }
}
