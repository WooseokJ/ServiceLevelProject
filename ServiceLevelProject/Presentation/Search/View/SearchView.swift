//
//  SearchView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import SnapKit
import UIKit

class SearchView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        return searchBar
    }()
    lazy var searchButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("새싹찾기", for: .normal)
        bt.backgroundColor = BrandColor.green
        bt.setTitleColor(BlackWhite.white, for: .normal)
        bt.layer.cornerRadius = 10
        bt.layer.borderWidth = 1
        bt.layer.borderColor = UIColor.clear.cgColor
        bt.clipsToBounds = true
        return bt
    }()
    
    lazy var collectionView: UICollectionView = {
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
        cv.backgroundColor = .lightGray
        cv.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        return cv
    }()
    
    
    override func configure() {
        [searchBar,collectionView,searchButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        searchButton.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-50)
            make.height.equalTo(UIScreen.main.bounds.height * 0.06)
        }
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(searchButton.snp.top).offset(-10)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(self.safeAreaLayoutGuide)
            
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
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
        switch indexPath.section {
            
        case 0:
            cell.itemButton.setTitle(InfoManageMent.title.list[indexPath.row], for: .normal)
        case 1:
            cell.itemButton.setTitle(InfoManageMent.sesacStudy.list[indexPath.row], for: .normal)
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionView.reuseIdentifier, for: indexPath) as? HeaderCollectionView else {return HeaderCollectionView()}
        switch indexPath.section {
            case 0 :header.label.text = "지금 주변에는"
            case 1: header.label.text = "내가 하고 싶은"
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
        switch indexPath.section {
        case 0: return CGSize(width: InfoManageMent.title.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
        case 1:
            return CGSize(width: InfoManageMent.sesacStudy.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
        default:
            print("오류",#function)
            return CGSize()

        }
    }
    
    //MARK: header와 셀 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 0, bottom: 30, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectItem = InfoManageMent.title.list[indexPath.row]
            print(InfoManageMent.sesacStudy.list)
//            InfoManageMent.title.list.map {}
            print(indexPath.row)
        case 1:
            print("색션1:",indexPath.row)
        default: break
        }
    }
    
}
