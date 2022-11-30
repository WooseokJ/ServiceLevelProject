//
//  SearchListView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/23.
//

import UIKit
import Tabman
import Pageboy


class SearchListView: BaseView {
    var cellDelegate: InfoDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var bar: TMBarView<TMHorizontalBarLayout, TMLabelBarButton, TMLineBarIndicator> = {
        let bar = TMBar.ButtonBar()
                
        //탭바 레이아웃 설정
        bar.indicator.weight = .custom(value: 2)
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = self.bounds.width / 2
        bar.scrollMode = .interactive
        bar.indicator.overscrollBehavior = .none
        bar.backgroundView.style = .blur(style: .light)

        //배경색
        bar.backgroundView.style = .clear
        //간격설정
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                
        //버튼 글시 커스텀
        bar.buttons.customize{ (button) in
            button.tintColor = Grayscale.gray6
            button.selectedTintColor = BrandColor.green
            button.font = AppFont.Title4_R14
        }
        bar.indicator.tintColor = BrandColor.green
        

        return bar
    }()
    
    var tampView = UIView()
    
    lazy var studyChangedButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("스터디 변경하기", for: .normal)
        bt.backgroundColor = BrandColor.green
        bt.setTitleColor(BlackWhite.white, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.clear.cgColor
        bt.clipsToBounds = true
        return bt
    }()
    lazy var refreshButton: UIButton = {
        let bt = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
        let image = UIImage(systemName: "arrow.clockwise", withConfiguration: imageConfig)
        bt.setImage(image, for: .normal)
        bt.tintColor = BrandColor.green
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = BrandColor.green.cgColor
        bt.clipsToBounds = true
        return bt
    }()
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sesacLogo.png")
        return image
    }()
    lazy var content: UILabel = {
        let label = UILabel()
        label.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    lazy var subContent: UILabel = {
        let label = UILabel()
        label.text = "스터디를 변경하거나 조금만 더 기다려 주세요!"
        label.textAlignment = .center
        label.textColor = Grayscale.gray7
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.backgroundColor = .clear
        tableview.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.reuseIdentifier)
        return tableview
    }()
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 1
        let layoutwidth = UIScreen.main.bounds.width
        let layoutheight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: layoutwidth / 2.5  , height: layoutheight / 29 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(InfoManageMentCollectionViewCell.self, forCellWithReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.backgroundColor = .yellow
        cv.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        return cv
    }()
    
    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = BlackWhite.white
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = BlackWhite.white.cgColor
        return view
    }()
    let requestAcceptTitle: UILabel = {
        let label = UILabel()
        label.text = "스터디를 요청할게요!"
        label.textAlignment = .center
        return label
    }()
    let subtitle: UILabel = {
        let label = UILabel()
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: "상대방이 요청을 수락하면\n채팅창에서 대화를 나눌 수 있어요", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = Grayscale.gray7
        return label
    }()
                                                    
    let cancelButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("취소", for: .normal)
        bt.backgroundColor = Grayscale.gray2
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = Grayscale.gray2.cgColor
        bt.setTitleColor(BlackWhite.black, for: .normal)
        return bt
    }()
    let okButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("확인", for: .normal)
        bt.backgroundColor = BrandColor.green
        bt.layer.cornerRadius = 8
        bt.layer.borderWidth = 1
        bt.layer.borderColor = BrandColor.green.cgColor
        return bt
    }()
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    override func configure() {
        [tampView,studyChangedButton, refreshButton,logoImage, content , subContent, tableView,collectionview,blackView,whiteView,stackView,cancelButton,okButton].forEach {
            self.addSubview($0)
        }
        [requestAcceptTitle,subtitle].forEach {
            self.stackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 0.0).isActive = true
        }

    }
    
    override func setConstrains() {
        tampView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(UIScreen.main.bounds.height * 0.05)
        }
        refreshButton.snp.makeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-50)
            make.width.equalTo(UIScreen.main.bounds.width * 0.15)
        }
        
        studyChangedButton.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-16)
            make.bottom.equalTo(refreshButton.snp.bottom)
            make.height.equalTo(refreshButton.snp.height)
        }
    }
    
    func EmptySetConstrains() {
        logoImage.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.9)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(44)
            make.leading.equalTo(56)
            make.trailing.equalTo(-56)
            make.height.equalTo(32)
        }
        subContent.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(8)
            make.leading.equalTo(content.snp.leading)
            make.trailing.equalTo(content.snp.trailing)
            make.height.equalTo(22)
        }
        tableView.snp.remakeConstraints{$0.width.height.equalTo(0)}
    }
    func TableViewSetConstrains() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tampView.snp.bottom)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(refreshButton.snp.top).offset(-1)
        }
        logoImage.snp.remakeConstraints{$0.width.height.equalTo(0)}
        content.snp.remakeConstraints{$0.width.height.equalTo(0)}
        subContent.snp.remakeConstraints{$0.width.height.equalTo(0)}
    }
    func collectionViewSetConstrains(cell: SearchListTableViewCell) {
        self.collectionview.snp.remakeConstraints { make in
            make.top.equalTo(cell.moreButton.snp.bottom)
            make.bottom.equalTo(cell.snp.bottom)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
    }
    func requestAcceptSetConstrains() {
        
        blackView.snp.remakeConstraints { make in
            make.edges.equalTo(self)
        }
        whiteView.snp.remakeConstraints { make in
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.center.equalTo(self)
        }
        stackView.snp.remakeConstraints { make in
            make.top.equalTo(whiteView.snp.top)
            make.leading.equalTo(whiteView.snp.leading)
            make.trailing.equalTo(whiteView.snp.trailing)
            make.height.equalTo(UIScreen.main.bounds.height * 0.15)
        }
        cancelButton.snp.remakeConstraints { make in
            make.leading.equalTo(whiteView.snp.leading).offset(20)
            make.width.equalTo(whiteView.snp.width).multipliedBy(0.4)
            make.bottom.equalTo(whiteView.snp.bottom).offset(-20)
            make.top.equalTo(stackView.snp.bottom).offset(20)
        }
        okButton.snp.remakeConstraints { make in
            make.trailing.equalTo(whiteView.snp.trailing).offset(-20)
            make.bottom.equalTo(cancelButton.snp.bottom)
            make.top.equalTo(cancelButton.snp.top)
            make.width.equalTo(whiteView.snp.width).multipliedBy(0.4)
        }
    }
    //        blackView.removeFromSuperview() //개꿀 !!!
    func cancelButtonClicked() {
        blackView.snp.remakeConstraints {$0.width.height.equalTo(0)}
        whiteView.snp.remakeConstraints {$0.width.height.equalTo(0)}
        stackView.snp.remakeConstraints {$0.width.height.equalTo(0)}
        cancelButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
        okButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
    }
    
    
}

//MARK: 상단 탭바
extension SearchListViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return VCS.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        searchListView.content.snp.remakeConstraints {$0.width.height.equalTo(0)}
        searchListView.logoImage.snp.remakeConstraints {$0.width.height.equalTo(0)}
        searchListView.subContent.snp.remakeConstraints {$0.width.height.equalTo(0)}
        searchListView.refreshButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
        searchListView.studyChangedButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
        return VCS[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "주변새싹")
        case 1:
            return TMBarItem(title: "받은요청")
        default:
            let title = "Page \(index)"
           return TMBarItem(title: title)
        }
    }
    
}






//MARK: 컬렉션뷰 
//extension AroundSeSacViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//    
//    func collectionviewConfigure() {
//        searchListView.collectionview.delegate = self
//        searchListView.collectionview.dataSource = self
//    }
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0 :
//            print(InfoManageMent.title.list.count)
//            return InfoManageMent.title.list.count
//        case 1:
//            print(InfoManageMent.sesacStudy.list.count)
//            return InfoManageMent.sesacStudy.list.count
//        default:
//            return 1
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoManageMentCollectionViewCell else{return UICollectionViewCell()}
//        cell.backgroundColor = .red
//        
//        switch indexPath.section {
//        case 0:
//            cell.reviewLabel.snp.remakeConstraints {$0.width.height.equalTo(0)}
//            cell.itemButton.titleLabel?.font = AppFont.Title4_R14
//            cell.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            cell.itemButton.setTitle(InfoManageMent.title.list[indexPath.row], for: .normal)
//        case 1:
//            cell.reviewLabel.snp.remakeConstraints {$0.width.height.equalTo(0)}
//            cell.itemButton.titleLabel?.font = AppFont.Title4_R14
//            cell.layer.cornerRadius = 10
//            cell.clipsToBounds = true
//            cell.itemButton.setTitle(InfoManageMent.sesacStudy.list[indexPath.row], for: .normal)
//        case 2:
////            infoManageView.collectionview.backgroundColor = .cyan
//            cell.reviewLabel.snp.remakeConstraints { make in
//                make.leading.equalTo(10)
//                make.top.equalTo(0)
//                make.trailing.equalTo(-10)
//                make.bottom.equalTo(cell.snp.bottom)
//            }
//            cell.itemButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
//            cell.reviewLabel.frame.size = cell.reviewLabel.intrinsicContentSize
//            cell.reviewLabel.text = "첫 리뷰를 기다리는 중이에요!"
//            cell.reviewLabel.textColor = Grayscale.gray6
//            cell.reviewLabel.layer.borderWidth = 0
//        default: break
//        }
//        return cell
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier, for: indexPath) as? HeaderCollectionView else {return HeaderCollectionView()}
//        switch indexPath.section {
//            case 0 :header.label.text = "새싹 타이틀"
//            case 1: header.label.text = "하고 싶은 스터디"
//            case 2: header.label.text = "새싹 리뷰"
//            default: break
//        }
//        header.backgroundColor = .clear
//        header.configure()
//        header.layoutSubviews()
//        return header
//
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 100, height: 30)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        switch indexPath.section {
//        case 0: return CGSize(width: InfoManageMent.title.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
//        case 1:
//            return CGSize(width: InfoManageMent.sesacStudy.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
//        case 2:
//            return CGSize(width: UIScreen.main.bounds.width   , height: UIScreen.main.bounds.height / 29 )
//        default:
//            print("오류",#function)
//            return CGSize()
//        }
//    }
//    
//}
