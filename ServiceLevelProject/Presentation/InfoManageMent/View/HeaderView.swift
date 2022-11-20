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
        return image
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
        [image].forEach {
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

}
