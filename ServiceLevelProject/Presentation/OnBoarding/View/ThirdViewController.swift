//
//  ThirdViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

class ThirdViewController: UIViewController {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 2
        titleLabel.text = "SeSAC Study"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.numberOfLines = 0

        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
            make.height.equalTo(100)
        }
        
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.trailing.leading.equalToSuperview()
        }
        imageView.image = UIImage(named: "onboarding_img3.png")
        
        
        
    }
    

  

}
