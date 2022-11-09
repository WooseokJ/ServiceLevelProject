//
//  SecondViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

class SecondViewController: UIViewController {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.tag = 1

        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        
        let fullText =  "스터디를 원하는 친구를 \n찾을수 잇어요"
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "스터디를 원하는 친구")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.green, range: range)
        titleLabel.attributedText = attribtuedString
        
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
        imageView.image = UIImage(named: "onboarding_img2.png")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
