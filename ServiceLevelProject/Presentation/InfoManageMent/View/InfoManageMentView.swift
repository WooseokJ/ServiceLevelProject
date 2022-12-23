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
        tableView.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: HeaderView.headerViewID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = false
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
        [tableView,collectionview].forEach {
            self.addSubview($0)
        }
    }
    override func setConstrains() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height)
        }

//        collectionview.snp.remakeConstraints { make in
////            make.top.equalTo(cell.moreButton.snp.bottom)
////            make.bottom.equalTo(tableView.snp.bottom).offset(-10)
////            make.leading.equalTo(30)
////            make.trailing.equalTo(-30)
//        }

    }
    
}
