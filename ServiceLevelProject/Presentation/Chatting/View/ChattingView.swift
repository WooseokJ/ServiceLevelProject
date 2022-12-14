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
        view.isHidden = true
        return view
    }()
    let rightButtonwhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = BlackWhite.white
        view.isHidden = true
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
        
        return bt
    }()
    
    
    
    lazy var rightButtonstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sesacReport, studyCancel, reviewAdd])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var modalWhiteView: UIView = {
        let view = UIView()
        view.backgroundColor = BlackWhite.white
        view.isHidden = true
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let modalTitle: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    let modalSubTitle: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textAlignment = .center
        label.textColor = BrandColor.green
        return label
    }()
    
    lazy var collectionview: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout(divideWidth: 2.5))
        cv.register(ChattingCollectionViewCell.self, forCellWithReuseIdentifier: ChattingCollectionViewCell.reuseIdentifier)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.alwaysBounceVertical = true
        cv.isHidden = true
        return cv
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Grayscale.gray2
        textView.isHidden = true
        textView.layer.cornerRadius = 8
        return textView
    }()
    let modalButton: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .lightGray
        bt.layer.cornerRadius = 8
        bt.isHidden = true
        return bt
    }()
    let cancelXMark: UIButton = {
        let bt = UIButton()
        bt.isHidden = true
        bt.setImage(UIImage(systemName: "xmark"), for: .normal)
        bt.setTitleColor(BlackWhite.white, for: .normal)
        return bt
        
    }()
    func collectionViewLayout(divideWidth: Double) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let layoutwidth = UIScreen.main.bounds.width
        let layoutheight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: layoutwidth / divideWidth  , height: layoutheight / 29 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    
    override func configure() {
        [stackView,dateTitleLabel,titleStackView,
         matchedSubTitle,tableView, blackView,
         rightButtonwhiteView, rightButtonstackView,
         modalWhiteView,modalTitle,modalSubTitle,
         collectionview, textView, modalButton,
         cancelXMark].forEach {
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
        rightButtonstackView.snp.remakeConstraints { make in
            make.edges.equalTo(rightButtonwhiteView.snp.edges)
        }

        rightButtonwhiteView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.1)
        }
        modalWhiteView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.55)
        }
        modalTitle.snp.makeConstraints { make in
            make.top.equalTo(modalWhiteView.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalTo(modalWhiteView.snp.centerX).multipliedBy(1)
        }
        modalSubTitle.snp.makeConstraints { make in
            make.top.equalTo(modalTitle.snp.bottom).offset(5)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(modalTitle.snp.height)
            make.centerX.equalTo(modalTitle.snp.centerX)
        }
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(modalSubTitle.snp.bottom).offset(5)
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
            make.height.equalTo(120)
        }
        textView.snp.makeConstraints { make in
            make.top.equalTo(collectionview.snp.bottom).offset(5)
            make.leading.equalTo(collectionview.snp.leading)
            make.trailing.equalTo(collectionview.snp.trailing)
            make.bottom.equalTo(modalButton.snp.top).offset(-26)
        }
        modalButton.snp.makeConstraints { make in
            make.bottom.equalTo(modalWhiteView.snp.bottom).offset(-16)
            make.trailing.equalTo(textView.snp.trailing)
            make.leading.equalTo(textView.snp.leading)
            make.height.equalTo(50)
        }
        cancelXMark.snp.makeConstraints { make in
            make.top.equalTo(modalTitle.snp.top)
            make.trailing.equalTo(modalWhiteView.snp.trailing).offset(-5)
            make.width.height.equalTo(60)
        }
 
    }
    
    func listButtonClicked() {
        blackView.snp.remakeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(0)
        }
        blackView.isHidden = false
        rightButtonwhiteView.isHidden = false
        rightButtonstackView.isHidden = false
    }
    
    func blackViewClicked() {
        [blackView,rightButtonstackView,rightButtonwhiteView,
        modalWhiteView,modalTitle,modalSubTitle,
         collectionview,textView,modalButton,cancelXMark].forEach{
            $0.isHidden = true
        }
    }
    
    func modalButtonClicked(title: String, subTitle: String, BtTitle: String) {
        blackView.snp.remakeConstraints { $0.edges.equalTo(0)}
        rightButtonwhiteView.isHidden = true
        rightButtonstackView.isHidden = true
        modalWhiteView.isHidden = false
        modalTitle.isHidden = false
        modalTitle.text = title
        modalSubTitle.isHidden = false
        modalSubTitle.text = subTitle
        collectionview.isHidden = false
        textView.isHidden = false
        modalButton.isHidden = false
        modalButton.setTitle(BtTitle, for: .normal)
        modalButton.setTitleColor(BlackWhite.white, for: .normal)
        cancelXMark.isHidden = false
        collectionview.reloadData()
    }
    
}



extension ChattingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionViewConfigure() {
        chattingView.collectionview.dataSource = self
        chattingView.collectionview.delegate = self
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CVEnum.review.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChattingCollectionViewCell.reuseIdentifier, for: indexPath) as! ChattingCollectionViewCell
        sesacList[indexPath.item] = 0
        cell.itemButton.backgroundColor = .clear
        cell.itemButton.setTitleColor(BlackWhite.black, for: .normal)
        cell.layer.cornerRadius = 8
        cell.layer.borderColor = Grayscale.gray4.cgColor

        chattingView.sesacReport.isSelected ? cell.itemButton.setTitle(CVEnum.sesacReport.allCases[indexPath.item].list, for: .normal) : cell.itemButton.setTitle(CVEnum.review.allCases[indexPath.item].list, for: .normal)
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellItem = collectionView.cellForItem(at: indexPath) as! ChattingCollectionViewCell


        
        switch indexPath.item {
        case 0...CVEnum.review.allCases.count:
            cellItem.itemButton.isSelected.toggle()
            if cellItem.itemButton.isSelected {
                sesacList[indexPath.item] = 1
                cellItem.itemButton.backgroundColor = BrandColor.green
                cellItem.itemButton.setTitleColor(BlackWhite.white, for: .normal)
            } else {
                sesacList[indexPath.item] = 0
                cellItem.itemButton.backgroundColor = .clear
                cellItem.itemButton.setTitleColor(BlackWhite.black, for: .normal)
            }
        default:break
        }
    }    
}


extension ChattingViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.text.isEmpty else {
            chattingView.modalButton.backgroundColor = BrandColor.green
            return
        }
        chattingView.modalButton.backgroundColor = .lightGray
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard textView.text.isEmpty else {
            chattingView.modalButton.backgroundColor = BrandColor.green
            return true
        }
        chattingView.modalButton.backgroundColor = .lightGray
        return true
    }
  
}
