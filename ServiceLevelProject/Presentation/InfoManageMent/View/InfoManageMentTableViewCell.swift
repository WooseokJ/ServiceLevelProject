//
//  InfoManageMentTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit
protocol InfoDelegate {
    
    func womanButtonTap()
    func moreButtonTap() 
}
class InfoManageMentTableViewCell: UITableViewCell {
    var cellDelegate: InfoDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        moreButton.addTarget(self, action: #selector(moreTap), for: .touchUpInside)
        womanButton.addTarget(self, action: #selector(womanTap), for: .touchUpInside)
        configure()
        setConstrains()
    }
    @objc func moreTap() {
          cellDelegate?.moreButtonTap()
      }
    @objc func womanTap() {
        cellDelegate?.womanButtonTap()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var content: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .red
   
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return bt
    }()
    lazy var womanButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("여자", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = Grayscale.gray4.cgColor
        return bt
    }()
    
    lazy var manButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("남자", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = Grayscale.gray4.cgColor
        return bt
    }()
    
    lazy var studyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  스터디를 입력해 주세요"
        return textField
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    

    
    lazy var ageRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 65"
        label.textColor = BrandColor.green
        return label
    }()
    

//    lazy var reviewLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .yellow
//        return label
//    }()

    
    func configure() {
        [content,moreButton,womanButton,manButton,studyTextField,lineView,ageRangeLabel].forEach {
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
