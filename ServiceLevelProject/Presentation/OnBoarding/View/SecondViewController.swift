//
//  SecondViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

class SecondViewController: UIViewController {
    let imageView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.numberOfLines = 0
        
        let fullText =  "스터디를 원하는 친구를 \n찾을수 잇어요"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "스터디를 원하는 친구")
        attribtuedString.addAttribute(.foregroundColor, value: BrandColor.green, range: range)
        label.attributedText = attribtuedString
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 1
        configure()
        setConstrains()
    }
    
    private func configure() {
        [titleLabel,imageView].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    private func setConstrains() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(70)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(70)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.trailing.leading.equalToSuperview()
        }
        imageView.image = UIImage(named: "onboarding_img2.png")
    }


}
