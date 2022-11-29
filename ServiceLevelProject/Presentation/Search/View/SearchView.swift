//
//  SearchView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/21.
//

import SnapKit
import UIKit

class SearchView: BaseView, UICollectionViewDelegate
{
    
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
        cv.backgroundColor = .clear

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
    func collectionviewConfigure() {
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0 : return totalList.count
        case 1: return myfavoriteList.count
        default: return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoManageMentCollectionViewCell.reuseIdentifier, for: indexPath) as? InfoManageMentCollectionViewCell else{return UICollectionViewCell()}
        switch indexPath.section {
        case 0:
            cell.itemButton.setTitle(totalList[indexPath.row], for: .normal)
            if recommendList.count <= indexPath.row {
                cell.layer.borderColor = Grayscale.gray5.cgColor
                cell.itemButton.setTitleColor(Grayscale.gray5, for: .normal)
                cell.layer.cornerRadius = 10
                cell.layer.borderWidth = 1
            } else {
                cell.layer.borderColor = SystemColor.error.cgColor
                cell.itemButton.setTitleColor(SystemColor.error, for: .normal)
                cell.layer.cornerRadius = 10
                cell.layer.borderWidth = 1
            }

        case 1:
            guard myfavoriteList.count != 0 else {
                return cell
            }
            cell.layer.borderColor = BrandColor.green.cgColor
            cell.itemButton.setTitleColor(BrandColor.green, for: .normal)
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.itemButton.setTitle("\(myfavoriteList[indexPath.row]) X", for: .normal)
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
    // 해더사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0: return CGSize(width: totalList[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 60 , height: totalList[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).height + 10)
        case 1:
            return CGSize(width: myfavoriteList[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 60, height: myfavoriteList[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).height + 10)
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
            guard myfavoriteList.count < 8  else {return}
            myfavoriteList.append(totalList[indexPath.row])
            totalList.remove(at: indexPath.row)
        case 1:
            totalList.append(myfavoriteList[indexPath.row])
            myfavoriteList.remove(at: indexPath.row)
        default: break
        }
        collectionView.reloadData()
    }
    
}
