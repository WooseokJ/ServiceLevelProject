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
        tableView.backgroundColor = .green
        tableView.separatorStyle = .none
        return tableView
    }()

    override func configure() {
        [tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstrains() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
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
        
        return headerView
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return InfoManageMent.content.list.count
        
//        return InfoManageMent.content.list.count
//        return 1

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoManageMentTableViewCell.reuseIdentifier, for: indexPath) as! InfoManageMentTableViewCell
        
        cell.content.text = InfoManageMent.content.list[indexPath.row]
        cell.cellDelegate = self
        cell.selectionStyle = .none
        
        bind(cell: cell, indexPath: indexPath)
   
        switch indexPath.row {
        case 0 :
            cell.moreButton.snp.remakeConstraints { make in
                make.height.equalTo(50)
                make.trailing.equalTo(-10)
                make.width.equalTo(cell.bounds.width * 0.2)
                make.top.equalTo(cell.safeAreaInsets)
            }
            cell.womanButton.snp.updateConstraints {$0.height.width.equalTo(0)}
            cell.layer.borderWidth = 1
            cell.layer.borderColor = Grayscale.gray4.cgColor
            cell.layer.cornerRadius = 10
            cell.content.text = "김계란"
        case 1:
            print(indexPath.row)
            cell.womanButton.snp.makeConstraints { make in
                make.top.equalTo(cell.snp.top)
                make.trailing.equalTo(-16)
                make.width.equalTo(cell.bounds.width * 0.2)
                make.height.equalTo(cell.bounds.height)
            }
        default:
            break


        }

        return cell
        
        
    }
    private func bind(cell: InfoManageMentTableViewCell, indexPath: IndexPath) {
        cell.moreButton.rx.tap
//            .map{self.isSelect}
            .bind { val in
                print(val)
                self.isSelect.toggle()
                self.tableView(self.infoManageView.tableView, heightForRowAt: indexPath)
                self.infoManageView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height / 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isSelect {
            if indexPath.row == 0 {
                return UIScreen.main.bounds.height / 4
            } else {
                return UIScreen.main.bounds.height / 12
            }
            
        } else {
            return UIScreen.main.bounds.height / 12
        }
       
    }
    
}


extension InfoManageMentViewController: InfoDelegate {
    
    func womanButtonTap() {
        print("사용하고 싶은 기능들 추가")
    }
    func moreButtonTap() {

    }
}


//func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
////        guard let header = view as? UITableViewHeaderFooterView else { return }
////
////
//////        let view: UIView = {
//////            let v = UIView(frame: .zero)
//////            v.backgroundColor = .brown
//////
//////            return v
//////        }()
//////
//////
//////        var detailView: UIView = {
//////            let view = UIView()
//////            view.layer.cornerRadius = 10
//////            view.layer.borderColor = BlackWhite.black.cgColor
//////            view.layer.borderWidth = 1
//////            return view
//////        }()
//////
//////        let image: UIImageView = {
//////            let image = UIImageView()
//////            image.image = UIImage(named: "img.png")
//////            return image
//////        }()
//////
//////        let morebutton:  UIButton = {
//////            let button = UIButton()
//////            button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
//////            button.backgroundColor = .red
//////            return button
//////        }()
//////
//////
//////        let nickName: UILabel = {
//////            let label = UILabel()
//////            label.text = "김계란"
//////            label.backgroundColor = .yellow
//////            return label
//////        }()
//////
//////
//////        [image,detailView,morebutton,nickName].forEach {
//////            header.addSubview($0)
//////        }
//////
//////        image.snp.makeConstraints { make in
//////            make.top.equalTo(header.snp.top)
//////            make.leading.equalTo(header.snp.leading)
//////            make.trailing.equalTo(header.snp.trailing)
//////            make.height.equalTo(header.snp.height).multipliedBy(0.8)
//////        }
//////        detailView.snp.makeConstraints { make in
//////            make.top.equalTo(image.snp.bottom)
//////            make.leading.equalTo(header.snp.leading)
//////            make.trailing.equalTo(header.snp.trailing)
//////            make.height.equalTo(header.snp.height).multipliedBy(0.2)
//////        }
//////        nickName.snp.makeConstraints { make in
//////            make.leading.equalTo(detailView.snp.leading).offset(10)
//////            make.width.equalTo(detailView.snp.width).multipliedBy(0.5)
//////            make.top.equalTo(detailView.snp.top)
//////            make.height.equalTo(50)
//////        }
//////        morebutton.snp.makeConstraints { make in
//////            make.trailing.equalTo(detailView.snp.trailing).offset(-10)
//////            make.top.equalTo(detailView.snp.top)
//////            make.width.equalTo(detailView.snp.width).multipliedBy(0.1)
//////            make.height.equalTo(50)
//////
//////        }
////
////        header.textLabel?.textColor = .systemBlue
////        header.backgroundView = view
////    }


//MARK: 크기
//    let collectionview : UICollectionView = {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .fractionalHeight(0.4))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                               heightDimension: .absolute(88))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                       subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        let spacing : CGFloat = 8
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        return cv
//    }()
