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
        tableView.alwaysBounceVertical = false
        
        return tableView
    }()
    
    lazy var secondTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(InfoManageMentTableViewCell.self, forCellReuseIdentifier: InfoManageMentTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    lazy var sesacReview: UITableView = {
        tableView.register(InfoManageMentTableViewCell.self, forCellReuseIdentifier: InfoManageMentTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    
    
    // 이미지 컬렉션뷰
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 1
        let layoutwidth = UIScreen.main.bounds.width
        let layoutheight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: layoutwidth / 2.5  , height: layoutheight / 29 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(InfoManageMentCollectionViewCell.self, forCellWithReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.backgroundColor = .clear
        cv.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)

        return cv
    }()
    
    lazy var secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing : CGFloat = 1
        let layoutwidth = UIScreen.main.bounds.width
        let layoutheight = UIScreen.main.bounds.height
        layout.itemSize = CGSize(width: layoutwidth / 4  , height: layoutheight / 29 )
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(InfoManageMentCollectionViewCell.self, forCellWithReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier)
        cv.layer.cornerRadius = 10
        cv.clipsToBounds = true
        cv.backgroundColor = .green
        cv.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)

        return cv
    }()
    
    
    
    
    
    
    override func configure() {
        [tableView,secondTableView,collectionview,secondCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height * 0.6)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.headerViewID) as? HeaderView else {
            return UIView()
        }
        if tableView == infoManageView.tableView {
            return headerView
        } else {
            headerView.image.snp.updateConstraints {$0.width.height.equalTo(0)}
            return headerView
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == infoManageView.secondTableView {
            return InfoManageMent.content.list.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoManageMentTableViewCell.reuseIdentifier, for: indexPath) as! InfoManageMentTableViewCell
        cell.cellDelegate = self
        
        if tableView == infoManageView.secondTableView {
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
                cell.studyTextField.delegate = self
            case 2:
                let switchView = UISwitch(frame: .zero)
                switchView.setOn(false, animated: true)
                switchView.addTarget(self, action: #selector(self.switchDidChange(_:)), for: .valueChanged)
                cell.accessoryView = switchView
            case 3:
                cell.ageRangeLabel.snp.remakeConstraints { make in
                    make.height.equalTo(cell.content.snp.height)
                    make.trailing.equalTo(cell.snp.trailing)
                    make.top.equalTo(cell.content.snp.top)
                    make.width.equalTo(cell.bounds.width * 0.2)
                }
                
                lazy var slider: UISlider = {
                    let slider = UISlider(frame: CGRect(x: 0, y: 140, width: cell.bounds.width * 0.9, height: 30))
                    //                    slider.backgroundColor = .yellow
                    slider.maximumValue = 65.0
                    slider.minimumValue = 18.0
                    
                    
                    return slider
                }()
                
                cell.accessoryView = slider
                
            case 4:
                print("회원탈퇴 클릭 ")
            default:
                
                break
            }
            
            
            cell.content.text = InfoManageMent.content.list[indexPath.row]
            //            cell.backgroundColor = .cyan
        } else {
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
                infoManageView.collectionview.snp.remakeConstraints { make in
                    make.top.equalTo(cell.moreButton.snp.bottom)
                    make.height.equalTo(cell.snp.height).multipliedBy(0.5)
                    make.leading.equalTo(30)
                    make.trailing.equalTo(-30)
                }
            }
            
            self.isSelect.toggle()
            cell.content.text = "김새싹"
            //            cell.backgroundColor = .yellow
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = Grayscale.gray2.cgColor
            //            cell.layer.borderColor = UIColor.red.cgColor
        }
        cell.selectionStyle = .none
        
        bind(cell: cell, indexPath: indexPath)
        
        
        return cell
        
        
    }
    @objc func switchDidChange(_ sender: UISwitch) {
        print("sender is \(sender.isOn)")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("ddd")
        
    }
    
    private func bind(cell: InfoManageMentTableViewCell, indexPath: IndexPath) {
        cell.moreButton.rx.tap
        //            .map{self.isSelect}
            .bind { val in
                print(self.isSelect)
                self.tableView(self.infoManageView.tableView, heightForRowAt: indexPath)
                self.infoManageView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == infoManageView.tableView {
            return UIScreen.main.bounds.height * 0.2
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            print("회원탈퇴")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == infoManageView.tableView {
            if !isSelect {
                tableView.snp.updateConstraints { make in
                    make.height.equalTo(UIScreen.main.bounds.height * 0.3)
                }
                return UIScreen.main.bounds.height * 0.07
                
            } else {
                tableView.snp.updateConstraints { make in
                    make.height.equalTo(UIScreen.main.bounds.height * 0.6)
                }
                return UIScreen.main.bounds.height * 0.4
                
            }
        } else {
            if indexPath.row == 3 {
                return UIScreen.main.bounds.height * 0.12
            }
            return UIScreen.main.bounds.height * 0.09
            
        }
        
        
        
    }
    
}


extension InfoManageMentViewController: InfoDelegate {
    
    func womanButtonTap() {
        
        
        
    }
    func moreButtonTap() {
        print(#function)
    }
    
    
}

extension InfoManageMentViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == infoManageView.collectionview {
            return InfoManageMent.title.list.count
        }
        else {
            return InfoManageMent.sesacStudy.list.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoManageMentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.itemButton.titleLabel?.font = AppFont.Title4_R14
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.itemButton.setTitle(InfoManageMent.title.list[indexPath.row], for: .normal)

        switch collectionView {
        case infoManageView.collectionview :

            print("ddd")
        case infoManageView.secondCollectionView:
            print("ttt")
            if isSelect {
                infoManageView.secondCollectionView.snp.remakeConstraints { make in
                    make.height.equalTo(infoManageView.collectionview.snp.height).multipliedBy(0.6)
                    make.top.equalTo(infoManageView.collectionview.snp.bottom)
                    make.leading.equalTo(30)
                    make.trailing.equalTo(-30)
                }
                cell.itemButton.setTitle(InfoManageMent.sesacStudy.list[indexPath.row], for: .normal)
            } else {
                infoManageView.secondCollectionView.snp.remakeConstraints{
                    $0.width.height.equalTo(0)
                }
            }
        default:
            break
        }
     
    

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier, for: indexPath) as? HeaderCollectionView else {
                return HeaderCollectionView()
            }
            header.backgroundColor = .darkGray
            header.configure()
            header.layoutSubviews()
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    

    
}
