//
//  ChattingView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/01.
//

import UIKit

class ChattingView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var dateTitleLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 20
        label.layer.borderColor = Grayscale.gray7.cgColor
        label.backgroundColor = Grayscale.gray7
        label.clipsToBounds = true
        label.layer.borderWidth = 1
        label.textColor = BlackWhite.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = AppFont.Title5_M12
        return label
    }()
    lazy var sendTextView: UITextView = {
        let textView = UITextView()
//        textView.placeholder = "  메세지를 입력하세요."
        textView.text = "  메세지를 입력하세요."
        textView.backgroundColor = Grayscale.gray1
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = Grayscale.gray1.cgColor
        return textView
    }()
    lazy var sendButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "paperplane"), for: .normal)
        bt.backgroundColor = .clear
        return bt
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sendTextView, sendButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.backgroundColor = Grayscale.gray1
        stackView.layer.cornerRadius = 8
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = Grayscale.gray1.cgColor
        return stackView
    }()
    lazy var bellimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = Grayscale.gray7
//        imageView.backgroundColor = .yellow
        return imageView
    }()
    lazy var matchedTitle: UILabel = {
        let label = UILabel()
        label.font = AppFont.Title3_M14
        label.textColor = Grayscale.gray7
//        label.backgroundColor = .brown
//        label.textAlignment = .natural
        return label
    }()
    lazy var matchedSubTitle: UILabel = {
        let label = UILabel()
        label.text = "채팅을 통해 약속을 정해보세요 :)"
        label.font = AppFont.Title4_R14
        label.textColor = Grayscale.gray6
//        label.textAlignment = .natural
        return label
    }()
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bellimageView, matchedTitle])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
//        stackView.backgroundColor = .red
        return stackView
    }()
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(MychatTableViewCell.self, forCellReuseIdentifier: MychatTableViewCell.reuseIdentifier)
        tableview.register(YourChatTableViewCell.self, forCellReuseIdentifier: YourChatTableViewCell.reuseIdentifier)
        return tableview
    }()
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = BlackWhite.white
        return view
    }()
    let sesacReport: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "sesacReport.png"), for: .normal)
        bt.setTitle("새싹 신고", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        let imageSize: CGSize = bt.imageView!.image!.size
        bt.titleEdgeInsets = UIEdgeInsets(top: 26 , left: -imageSize.width, bottom: 0.0, right: 0.0);
        let labelString = NSString(string: bt.titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: AppFont.Title3_M14])
        bt.imageEdgeInsets = UIEdgeInsets(top: -30, left: 0.0, bottom: 0.0, right: -titleSize.width - 20);
        return bt
    }()
    let studyCancel: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "studyCancel.png"), for: .normal)
        bt.setTitle("스터디 취소", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        let imageSize: CGSize = bt.imageView!.image!.size
        bt.titleEdgeInsets = UIEdgeInsets(top: 26 , left: -imageSize.width, bottom: 0.0, right: 0.0);
        let labelString = NSString(string: bt.titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: AppFont.Title3_M14])
        bt.imageEdgeInsets = UIEdgeInsets(top: -30, left: 0.0, bottom: 0.0, right: -titleSize.width - 20);
        return bt
    }()
    let reviewAdd: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "reviewAdd.png"), for: .normal)
        bt.setTitle("리뷰 등록", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        let imageSize: CGSize = bt.imageView!.image!.size
        bt.titleEdgeInsets = UIEdgeInsets(top: 26 , left: -imageSize.width, bottom: 0.0, right: 0.0);
        let labelString = NSString(string: bt.titleLabel!.text!)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: AppFont.Title3_M14])
        bt.imageEdgeInsets = UIEdgeInsets(top: -30, left: 0.0, bottom: 0.0, right: -titleSize.width - 20);
        
        
//        myButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        return bt
    }()
    lazy var rightButtonstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sesacReport, studyCancel, reviewAdd])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    
    
    override func configure() {
        [stackView,dateTitleLabel,titleStackView,
         matchedSubTitle,tableView, blackView,
         whiteView, rightButtonstackView].forEach {
            self.addSubview($0)
        }
    }
    override func setConstrains() {
        
        dateTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(130)
            make.trailing.equalTo(-130)
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
            make.centerY.equalTo(self.snp.centerY).multipliedBy(0.28)
        }
        
        sendTextView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(stackView.snp.top)
            make.width.equalTo(stackView.snp.width).multipliedBy(0.9)
            make.leading.equalTo(0)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-50)
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
        }

        
        
        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(dateTitleLabel.snp.bottom).offset(12)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(UIScreen.main.bounds.height * 0.04)
            make.leading.equalTo(100)
            make.trailing.equalTo(0)
        }
        matchedSubTitle.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(2)
            make.height.equalTo(titleStackView.snp.height)
            make.width.equalTo(titleStackView.snp.width)
            make.centerX.equalTo(titleStackView.snp.centerX)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(matchedSubTitle.snp.bottom)
            make.bottom.equalTo(stackView.snp.top)
            make.leading.trailing.equalTo(0)
        }
        rightButtonstackView.snp.remakeConstraints{$0.width.height.equalTo(0)}
        
    }
    func rightBarButtonClicked() {
        blackView.snp.remakeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
            
        }
        whiteView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.11)
        }
        rightButtonstackView.snp.remakeConstraints { make in
            make.edges.equalTo(whiteView.snp.edges)
        }
    }
    
    func rightBarButtonHidden() {
        rightButtonstackView.isHidden = false
        whiteView.isHidden = true
    }
    
    func studyCancelClicked() {
        rightButtonstackView.isHidden = true
        blackView.snp.remakeConstraints {$0.edges.equalTo(0)}
        whiteView.snp.remakeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.2)
            make.center.equalTo(self.snp.center)
        }
        whiteView.layer.cornerRadius = 20
        
        
    }
    
    
    
}

