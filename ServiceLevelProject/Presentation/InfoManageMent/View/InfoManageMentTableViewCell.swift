//
//  InfoManageMentTableViewCell.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit
protocol InfoDelegate {
    func switchDidChange(cell: InfoManageMentTableViewCell)
    func textFieldChagned(cell: InfoManageMentTableViewCell)
    func sliderValueChagend(cell: InfoManageMentTableViewCell)
    func manButtonTap(cell: InfoManageMentTableViewCell)
    func womanButtonTap(cell: InfoManageMentTableViewCell)
    func moreButtonTap()
    
}
class InfoManageMentTableViewCell: UITableViewCell {
    var cellDelegate: InfoDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        moreButton.addTarget(self, action: #selector(moreTap), for: .touchUpInside)
        womanButton.addTarget(self, action: #selector(womanTap(_:)), for: .touchUpInside)
        manButton.addTarget(self, action: #selector(manTap(_:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderChaged(_:)), for: .touchUpInside)
        studyTextField.addTarget(self, action: #selector(textFieldEditing(_:)), for: .editingChanged)
        switchView.addTarget(self, action: #selector(switchChagend(_:)), for: .valueChanged)
        configure()
        setConstrains()
    }
    @objc func moreTap() {cellDelegate?.moreButtonTap()}
    @objc func womanTap(_ sender: UIButton) {cellDelegate?.womanButtonTap(cell: self)}
    @objc func manTap(_ sender: UIButton) {cellDelegate?.manButtonTap(cell: self)}
    @objc func sliderChaged(_ sender: UISlider) {cellDelegate?.sliderValueChagend(cell: self)}
    @objc func textFieldEditing(_ sender: UITextField) {cellDelegate?.textFieldChagned(cell: self)}
    @objc func switchChagend(_ sender: UISwitch) {cellDelegate?.switchDidChange(cell: self)}
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
    lazy var switchView: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        return switchView
    }()
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Grayscale.gray3
        return view
    }()
    lazy var ageRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "18 - 18"
        label.textColor = BrandColor.green
        return label
    }()
    lazy var slider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 140, width: self.bounds.width * 0.9, height: 30))
        slider.maximumValue = 65.0
        slider.minimumValue = 18.0
        return slider
    }()
    
    func configure() {
        [content,moreButton,womanButton,manButton,studyTextField,lineView,ageRangeLabel,slider,switchView].forEach {
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
