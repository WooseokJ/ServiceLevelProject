//
//  InfoManageMentView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit
import SnapKit

class InfoManageMentView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(InfoManageMentTableViewCell.self, forCellReuseIdentifier: InfoManageMentTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    lazy var secondTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(InfoManageMentTableViewCell.self, forCellReuseIdentifier: InfoManageMentTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false
        return tableView
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
        cv.backgroundColor = .clear
        cv.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        return cv
    }()
    
    override func configure() {
        [tableView,secondTableView,collectionview].forEach {
            self.addSubview($0)
        }
    }
    override func setConstrains() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        secondTableView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

extension InfoManageMentViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: 색션,셀
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case infoManageView.tableView: return 1
        case infoManageView.secondTableView : return 1
        default: return 1
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            case infoManageView.secondTableView: return InfoManageMent.content.list.count
            case infoManageView.tableView: return 1
            default:
            print("오류",#function)
            return 1
        }
        
    }
    
    //MARK: 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoManageMentTableViewCell.reuseIdentifier, for: indexPath) as! InfoManageMentTableViewCell
        cell.cellDelegate = self
        cell.slider.isHidden = true
        cell.switchView.isHidden = true
        
        switch tableView {
            
        case infoManageView.secondTableView:
            print("scond")
            switch indexPath.row {
            case 0:
                cell.womanButton.snp.remakeConstraints { make in
                    make.trailing.equalTo(-5)
                    make.height.equalTo(cell.snp.height).multipliedBy(0.8)
                    make.centerY.equalTo(cell.snp.centerY)
                    make.width.equalTo(cell.bounds.width * 0.2)
                }
                cell.manButton.snp.remakeConstraints { make in
                    make.trailing.equalTo(cell.womanButton.snp.leading).offset(-10)
                    make.height.equalTo(cell.snp.height).multipliedBy(0.8)
                    make.centerY.equalTo(cell.snp.centerY)
                    make.width.equalTo(cell.bounds.width * 0.2)
                }
            case 1:
                cell.studyTextField.snp.remakeConstraints { make in
                    make.trailing.equalTo(-5)
                    make.width.equalTo(cell.bounds.width * 0.5)
                    make.height.equalTo(cell.content.snp.height)
                    make.centerY.equalTo(cell.snp.centerY)
                }
                cell.lineView.snp.remakeConstraints { make in
                    make.height.equalTo(1)
                    make.top.equalTo(cell.studyTextField.snp.bottom)
                    make.leading.equalTo(cell.studyTextField.snp.leading)
                    make.trailing.equalTo(cell.snp.trailing)
                }

            case 2:
                cell.switchView.isHidden = false
                cell.accessoryView = cell.switchView
            case 3:
                cell.ageRangeLabel.snp.remakeConstraints { make in
                    make.height.equalTo(cell.content.snp.height)
                    make.trailing.equalTo(cell.snp.trailing)
                    make.top.equalTo(cell.content.snp.top)
                    make.width.equalTo(cell.bounds.width * 0.2)
                }
                cell.slider.isHidden = false

                cell.accessoryView = cell.slider
            case 4:
                print("회원탈퇴 클릭 ")
            default:
                break
            }
            cell.content.text = InfoManageMent.content.list[indexPath.row]
            
        case infoManageView.tableView:
            print("테이블뷰야야야야 ")
            cell.content.font = AppFont.Title1_M16
            cell.moreButton.snp.remakeConstraints { make in
                make.height.equalTo(cell.content.snp.height)
                make.trailing.equalTo(-5)
                make.width.equalTo(cell.bounds.width * 0.2)
                make.top.equalTo(cell.safeAreaInsets)
            }
            if isSelect {
                infoManageView.collectionview.snp.remakeConstraints{
                    $0.width.height.equalTo(0)
                }
            } else {
//                infoManageView.collectionview.backgroundColor = .red
                infoManageView.collectionview.snp.remakeConstraints { make in
                    make.top.equalTo(cell.moreButton.snp.bottom)
                    make.bottom.equalTo(infoManageView.tableView.snp.bottom).offset(-10)
                    make.leading.equalTo(30)
                    make.trailing.equalTo(-30)
                }
            }
            self.isSelect.toggle()
            cell.content.text = "김새싹"
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = Grayscale.gray2.cgColor
        default:
            print("오류",#function)
            break
        }
        
        cell.selectionStyle = .none
        bind(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    
    private func bind(cell: InfoManageMentTableViewCell, indexPath: IndexPath) {
        cell.moreButton.rx.tap
            .bind { val in
                print(self.isSelect)
                self.tableView(self.infoManageView.tableView, heightForRowAt: indexPath)
                self.infoManageView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {print("회원탈퇴")}
    }
    //MARK: 해더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.headerViewID) as? HeaderView else {
            return UIView()
        }
        switch tableView {
        case infoManageView.tableView: break
        case infoManageView.secondTableView:
            headerView.image.snp.updateConstraints {$0.width.height.equalTo(0)}
        default: break
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case infoManageView.tableView : return UIScreen.main.bounds.height * 0.2
        case infoManageView.secondTableView : return 0
        default: print("오류",#function); return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case infoManageView.tableView:
            if isSelect {
                tableView.snp.remakeConstraints { make in
                    make.leading.equalTo(16)
                    make.trailing.equalTo(-16)
                    make.top.equalTo(self.view.safeAreaLayoutGuide)
                    make.height.equalTo(UIScreen.main.bounds.height * 0.7) // 열려있을떄 테이블뷰 자체 높이
                }
//                return UIScreen.main.bounds.height * 0.5 // 펼쳣을떄  셀 높이
                return UITableView.automaticDimension
            } else {

                tableView.snp.remakeConstraints { make in
                    make.leading.equalTo(16)
                    make.trailing.equalTo(-16)
                    make.top.equalTo(self.view.safeAreaLayoutGuide)
                    make.height.equalTo(UIScreen.main.bounds.height * 0.26) // 닫혀있을떄 테이블뷰 자체 높이
                }
//                return UIScreen.main.bounds.height * 0.04 // 닫힐떄 셀 높이
                return UITableView.automaticDimension // 닫힐떄 셀 높이
            }
        case infoManageView.secondTableView:
            if indexPath.row == 3 {return UIScreen.main.bounds.height * 0.12}
            else {return UIScreen.main.bounds.height * 0.1}
        default:
            print("오류",#function)
            return 0
        }
    }
    
}


extension InfoManageMentViewController: InfoDelegate {
    func switchDidChange(cell: InfoManageMentTableViewCell) {
        print(cell.switchView.isOn)
    }
    func womanButtonTap(cell: InfoManageMentTableViewCell) {
        cell.womanButton.backgroundColor = BrandColor.green
        cell.manButton.backgroundColor = .clear
    }
    func manButtonTap(cell: InfoManageMentTableViewCell) {
        cell.manButton.backgroundColor = BrandColor.green
        cell.womanButton.backgroundColor = .clear
    }
    func sliderValueChagend(cell: InfoManageMentTableViewCell) {
        cell.ageRangeLabel.text = "18 - \(Int(cell.slider.value))"
    }
    func textFieldChagned(cell: InfoManageMentTableViewCell) {
        print(cell.studyTextField.text!)
    }
    func moreButtonTap() {}
}

extension InfoManageMentViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 : return InfoManageMent.title.list.count
        case 1: return InfoManageMent.sesacStudy.list.count
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoManageMentCollectionViewCell else{return UICollectionViewCell()}
        cell.itemButton.tag = indexPath.row
        switch indexPath.section {
        case 0:
            cell.reviewLabel.snp.remakeConstraints {$0.width.height.equalTo(0)}
            cell.itemButton.titleLabel?.font = AppFont.Title4_R14
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.itemButton.setTitle(InfoManageMent.title.list[indexPath.row], for: .normal)
        case 1:
            cell.reviewLabel.snp.remakeConstraints {$0.width.height.equalTo(0)}
            cell.itemButton.titleLabel?.font = AppFont.Title4_R14
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.itemButton.setTitle(InfoManageMent.sesacStudy.list[indexPath.row], for: .normal)
        case 2:
            infoManageView.collectionview.backgroundColor = .cyan
            cell.reviewLabel.snp.remakeConstraints { make in
                make.leading.equalTo(10)
                make.top.equalTo(0)
                make.trailing.equalTo(-10)
                make.bottom.equalTo(cell.snp.bottom)
            }
            cell.reviewLabel.frame.size = cell.reviewLabel.intrinsicContentSize
            cell.reviewLabel.text = "긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴긴문자긴"
            cell.reviewLabel.backgroundColor = .yellow
        default: break
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier, for: indexPath) as? HeaderCollectionView else {return HeaderCollectionView()}
        switch indexPath.section {
            case 0 :header.label.text = "새싹 타이틀"
            case 1: header.label.text = "하고 싶은 스터디"
            case 2: header.label.text = "새싹 리뷰"
            default: break
        }
        header.backgroundColor = .clear
        header.configure()
        header.layoutSubviews()
        return header

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoManageMentCollectionViewCell else { return .zero}
        cell.itemButton.sizeToFit()
        let cellwidth = cell.itemButton.frame.width + 60

        let layoutwidth = UIScreen.main.bounds.width
        let layoutheight = UIScreen.main.bounds.height
        switch indexPath.section {
        case 0: return CGSize(width: layoutwidth / 2.5  , height: layoutheight / 29 )
        case 1:
            return CGSize(width: layoutwidth / 4  , height: layoutheight / 29 )
        case 2: return CGSize(width: layoutwidth  , height: layoutheight / 29 )
        default:
            print("오류",#function)
            return CGSize()

        }
    }

    
}
