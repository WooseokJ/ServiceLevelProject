//
//  HeaderView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/19.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {
    static let headerViewID = "HeaderView"
    
    var detailView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = BlackWhite.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img.png")
        image.isHidden = true
        return image
    }()

    lazy var requestButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = SystemColor.error
        bt.setTitle("요청하기", for: .normal)
        bt.setTitleColor(BlackWhite.white, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderColor = SystemColor.error.cgColor
        bt.layer.borderWidth = 1
        bt.clipsToBounds = true
        return bt
    }()
    lazy var acceptButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = SystemColor.success
        bt.setTitle("수락하기", for: .normal)
        bt.setTitleColor(BlackWhite.white, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderColor = SystemColor.success.cgColor
        bt.layer.borderWidth = 1
        bt.clipsToBounds = true
        return bt
    }()

    override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            setupHeaderView()
            configureLayout()
        }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
    }
    
    private func setupHeaderView() {
        [image,requestButton,acceptButton].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    private func configureLayout() {
        image.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.height.equalTo(self.snp.height)
        }
    }
    func requestButtonConstrains() {
        requestButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.trailing.equalTo(-16)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.width).multipliedBy(0.3)
        }
    }
    func acceptButtonConstrains() {
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.trailing.equalTo(-16)
            make.height.equalTo(snp.height).multipliedBy(0.2)
            make.width.equalTo(snp.width).multipliedBy(0.3)
        }
    }

}
