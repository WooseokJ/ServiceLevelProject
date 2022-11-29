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
        bt.backgroundColor = .blue
        return bt
    }()
    
    func configure() {
        [moreButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        moreButton.snp.makeConstraints { make in
            make.height.equalTo(self.bounds.height * 0.8)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.trailing.equalTo(-16)
            make.width.equalTo(self.bounds.width * 0.2)
        }
    }
    
}
