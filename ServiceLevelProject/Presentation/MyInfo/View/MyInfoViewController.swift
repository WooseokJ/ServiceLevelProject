//
//  MyInfoViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/16.
//

import UIKit

class MyInfoViewController: BaseViewController {
    
    let myinfoView = MyInfoView()
    override func loadView() {
        super.view = myinfoView
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Int,String>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "내정보"
        myinfoView.collectionview.alwaysBounceVertical = false
        myinfoView.collectionview.collectionViewLayout = createLayout()
        configureDataSource()
        myinfoView.collectionview.delegate = self
    }
    
}

extension MyInfoViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
        
//        var config = UICollectionLayoutListConfiguration(appearance: .plain)
//        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    
    private func configureDataSource() {
        var cellRegisteration = UICollectionView.CellRegistration<UICollectionViewListCell,String> (handler: {cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = MyInfo.allCases[indexPath.section].list[indexPath.row]
            content.textProperties.color = .black
            switch indexPath.item {
                case 0:content.image = UIImage(named: "profile_img.png")
                case 1: content.image = UIImage(named: "notice.png")
                case 2: content.image = UIImage(named: "faq.png")
                case 3: content.image = UIImage(named: "qna.png")
                case 4: content.image = UIImage(named: "setting_alarm.png")
                case 5: content.image = UIImage(named: "permit.png")
                default:break
            }
            cell.accessories = [.disclosureIndicator()]
            
            cell.contentConfiguration = content
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
//            backgroundConfig.backgroundColor = .lightGray
            cell.backgroundConfiguration = backgroundConfig
        })
        
        // cv.
        dataSource = UICollectionViewDiffableDataSource(collectionView: myinfoView.collectionview, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: itemIdentifier) // indexPath, itemIdentifier 둘다 이용해서 cell에 접근가능
            cell.backgroundColor = .clear
            return cell
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Int,String>()
        snapShot.appendSections([0])
        snapShot.appendItems(MyInfo.content.list)
        dataSource.apply(snapShot)
        
        
    }
}


extension MyInfoViewController: UICollectionViewDelegate, LoginProtocol {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0 :
            login { data in
                let vc = InfoManageMentViewController()
                vc.userInfoData = data
                print(data)
                self.transition(vc,transitionStyle: .push)
            }
        default:
            self.view.makeToast("준비중입니다.")
            break
        }
    }
    
}
