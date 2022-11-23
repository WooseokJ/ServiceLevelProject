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
//        bt.setTitle("스터디 변경하기", for: .normal)
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
    
    override func configure() {
        [tampView,studyChangedButton, refreshButton,logoImage, content , subContent].forEach {
            self.addSubview($0)
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
    }
    
}

//MARK: 상단 탭바
extension SearchListViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return VCS.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        searchListView.content.snp.remakeConstraints{$0.width.height.equalTo(0)}
        searchListView.logoImage.snp.remakeConstraints{$0.width.height.equalTo(0)}
        searchListView.subContent.snp.remakeConstraints{$0.width.height.equalTo(0)}
        searchListView.refreshButton.snp.remakeConstraints{$0.width.height.equalTo(0)}
        searchListView.studyChangedButton.snp.remakeConstraints{$0.width.height.equalTo(0)}
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
