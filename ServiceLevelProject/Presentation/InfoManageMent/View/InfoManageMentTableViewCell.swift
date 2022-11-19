//
//  InfoManageMentTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit

protocol InfoDelegate: AnyObject {
    // 위임해줄 기능
    func womanButtonTap()
    func moreButtonTap()
}

class InfoManageMentTableViewCell: UITableViewCell {
    var cellDelegate: InfoDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.womanButton.addTarget(self, action: #selector(womanButtonDelegate), for: .touchUpInside)
        self.moreButton.addTarget(self, action: #selector(moreButtonDelegate), for: .touchUpInside)
        configure()
        setConstrains()
    }
    
    @objc func womanButtonDelegate(test: Int) {
     cellDelegate?.womanButtonTap()
    }
    
    @objc func moreButtonDelegate() {
        cellDelegate?.moreButtonTap()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .darkGray
        return bt
    }()
    
    lazy var womanButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("여자", for: .normal)
        bt.backgroundColor = .cyan
        bt.layer.cornerRadius = 10
        bt.layer.borderColor = UIColor.black.cgColor
        bt.layer.borderWidth = 1
        return bt
    }()
    
    func configure() {
        [content,womanButton,moreButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    func setConstrains() {
        content.snp.makeConstraints { make in
            make.height.equalTo(self.bounds.height * 0.8)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalTo(16)
            make.width.equalTo(self.bounds.width * 0.4)
        }

    }
    
    
    
 

}
