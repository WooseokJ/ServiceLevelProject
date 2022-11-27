//
//  MyInfoView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/16.
//

import UIKit

class MyInfoView: BaseView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //MARK: 크기
    let collectionview : UICollectionView = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.4))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(88))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        let spacing : CGFloat = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    
    //MARK: 뷰등록
    
    override func configure() {
        self.addSubview(collectionview)
    }
    
    //MARK: 위치
    override func setConstrains() {
        collectionview.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(0)
        }
    }
    
    
}
