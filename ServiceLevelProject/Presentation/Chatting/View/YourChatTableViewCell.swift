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
    
    
    
    
    func configure() {
        [].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        
    }

}
