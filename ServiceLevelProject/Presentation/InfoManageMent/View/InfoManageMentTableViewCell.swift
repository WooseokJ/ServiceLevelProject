//
//  InfoManageMentTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit
import MultiSlider

protocol InfoDelegate {
    func switchDidChange(cell: InfoManageMentTableViewCell)
    func textFieldChagned(cell: InfoManageMentTableViewCell)
    func sliderValueChagend(cell: InfoManageMentTableViewCell)
    func manButtonTap(cell: InfoManageMentTableViewCell)
    func womanButtonTap(cell: InfoManageMentTableViewCell)
    func withdrawButtonTap()
    func moreButtonTap()
}

class InfoManageMentTableViewCell: UITableViewCell {
    var cellDelegate: InfoDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        moreButton.addTarget(self, action: #selector(moreTap), for: .touchUpInside)
        womanButton.addTarget(self, action: #selector(womanTap(_:)), for: .touchUpInside)
        manButton.addTarget(self, action: #selector(manTap(_:)), for: .touchUpInside)
        studyTextField.addTarget(self, action: #selector(textFieldEditing(_:)), for: .editingChanged)
        switchView.addTarget(self, action: #selector(switchChagend(_:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderChaged(_:)), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(withdrawButtonTap), for: .touchUpInside)
        configure()
        setConstrains()
    }
    
    @objc func moreTap() {cellDelegate?.moreButtonTap()}
    @objc func womanTap(_ sender: UIButton) {cellDelegate?.womanButtonTap(cell: self)}
    @objc func manTap(_ sender: UIButton) {cellDelegate?.manButtonTap(cell: self)}
    @objc func sliderChaged(_ sender: UISlider) {cellDelegate?.sliderValueChagend(cell: self)}
    @objc func textFieldEditing(_ sender: UITextField) {cellDelegate?.textFieldChagned(cell: self)}
    @objc func switchChagend(_ sender: UISwitch) {cellDelegate?.switchDidChange(cell: self)}
    @objc func withdrawButtonTap() {cellDelegate?.withdrawButtonTap()}
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var content: UILabel = {
        let label = UILabel()
        return label
    }()
    lazy var moreButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        bt.isHidden = true
        return bt
    }()
    lazy var womanButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("여자", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = Grayscale.gray4.cgColor
        bt.isHidden = true
        return bt
    }()
    lazy var manButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("남자", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = Grayscale.gray4.cgColor
        bt.isHidden = true
        return bt
    }()
    lazy var studyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  스터디를 입력해 주세요"
        textField.isHidden = true
        return textField
    }()
    lazy var switchView: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.isHidden = true
        return switchView
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        view.isHidden = true
        return view
    }()
    lazy var ageRangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = BrandColor.green
        label.isHidden = true
        return label
    }()
    lazy var withdrawButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        return button
    }()
    
    lazy var slider: MultiSlider = {
        let slider = MultiSlider(frame: CGRect(x: 0, y: 140, width: self.bounds.width , height: 30))
        slider.minimumValue = 18.0    // default is 0.0
        slider.maximumValue = 65.0    // default is 1.0
        slider.value = [slider.minimumValue, slider.maximumValue]
        slider.orientation = .horizontal // default is .vertical
        slider.snapStepSize = 1
        slider.outerTrackColor = .lightGray
        slider.isHidden = true
        return slider
    }()
    
    func configure() {
        [content,moreButton,womanButton,manButton,studyTextField,lineView,ageRangeLabel,slider,switchView,withdrawButton].forEach {
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
        womanButton.snp.remakeConstraints { make in
            make.trailing.equalTo(-5)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.bounds.width * 0.2)
        }
        manButton.snp.remakeConstraints { make in
            make.trailing.equalTo(self.womanButton.snp.leading).offset(-10)
            make.height.equalTo(self.snp.height).multipliedBy(0.8)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(self.bounds.width * 0.2)
        }
        studyTextField.snp.remakeConstraints { make in
            make.trailing.equalTo(-5)
            make.width.equalTo(self.bounds.width * 0.6)
            make.height.equalTo(self.content.snp.height)
            make.centerY.equalTo(self.snp.centerY)
        }
        lineView.snp.remakeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(self.studyTextField.snp.bottom)
            make.leading.equalTo(self.studyTextField.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        ageRangeLabel.snp.remakeConstraints { make in
            make.height.equalTo(self.content.snp.height)
            make.trailing.equalTo(self.snp.trailing)
            make.top.equalTo(self.content.snp.top)
            make.width.equalTo(self.bounds.width * 0.2)
        }
        moreButton.snp.remakeConstraints { make in
            make.height.equalTo(self.content.snp.height)
            make.trailing.equalTo(-5)
            make.width.equalTo(self.bounds.width * 0.2)
            make.top.equalTo(self.safeAreaInsets)
        }
        withdrawButton.snp.remakeConstraints { make in
            make.edges.equalTo(self)
        }

    }
    
    
    
 

}
