//
//  InfoManageMentViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/17.
//

import UIKit

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}

class MyUpdateInfo {
    static var shared = MyUpdateInfo()
    var searchable: Int?
    var ageMin: Int?
    var ageMax: Int?
    var gender: Int?
    var study: String?

}

class InfoManageMentViewController: BaseViewController, WithdrawProtocol, MypageProtocol {
    
    let infoManageView = InfoManageMentView()
    var userInfoData: LoginInfo?
    
    override func loadView() {
        super.view = infoManageView
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutKeyboard()
        tableViewConfigure()
//        collectionviewConfigure()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.title = "정보 관리"
        hideKeyboard()
    }
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    @objc func saveButtonClicked() {
        myPageUpdate(searchable: MyUpdateInfo.shared.searchable!, ageMin: MyUpdateInfo.shared.ageMin!, ageMax: MyUpdateInfo.shared.ageMax!, gender: MyUpdateInfo.shared.gender!, study: MyUpdateInfo.shared.study!) { data in
            print(data)
            print("저장클릭")
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension InfoManageMentViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableViewConfigure() {
        infoManageView.tableView.delegate = self
        infoManageView.tableView.dataSource = self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("====",section)
        return (section == 0) ? 1 : InfoManageMent.content.list.count
    }
    //MARK: 셀
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoManageMentTableViewCell.reuseIdentifier, for: indexPath) as! InfoManageMentTableViewCell
        cell.cellDelegate = self
        switch indexPath.section {
        case 0:
            cell.moreButton.isHidden = false
            cell.content.font = AppFont.Title1_M16
            cell.content.text = userInfoData?.nick!
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1
            cell.layer.borderColor = Grayscale.gray2.cgColor
        case 1:
            
            switch indexPath.row {
            case 0:
                cell.womanButton.isHidden = false
                cell.manButton.isHidden = false
                (userInfoData?.gender! == 0) ?  womanButtonTap(cell: cell) : manButtonTap(cell: cell)
                MyUpdateInfo.shared.gender = userInfoData?.gender!
            case 1:
                cell.studyTextField.isHidden = false
                cell.lineView.isHidden = false
                MyUpdateInfo.shared.study = cell.studyTextField.text
            case 2:
                cell.switchView.isHidden = false
                cell.accessoryView = cell.switchView
                cell.switchView.isOn = (userInfoData?.searchable! == 0) ? false : true
                MyUpdateInfo.shared.searchable = cell.switchView.isOn.intValue
            case 3:
                cell.ageRangeLabel.isHidden = false
                cell.slider.isHidden = false
                cell.slider.value = [Double(userInfoData!.ageMin!), Double(userInfoData!.ageMax!)]
                cell.ageRangeLabel.text = "\(userInfoData!.ageMin!) - \(userInfoData!.ageMax!)"
                cell.accessoryView = cell.slider
                MyUpdateInfo.shared.ageMin = userInfoData!.ageMin!
                MyUpdateInfo.shared.ageMax = userInfoData!.ageMax!
            case 4:
                cell.withdrawButton.isHidden = false
            default:
                break
            }
            cell.content.text = InfoManageMent.content.list[indexPath.row]
        default:break
        }
//        cell.backgroundColor = .yellow
        cell.selectionStyle = .none
        return cell
    }
    //MARK: 해더
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.headerViewID) as? HeaderView else {
            return UIView()
        }

        headerView.image.isHidden = (section == 0) ? false : true
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? UIScreen.main.bounds.height * 0.2 : 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 0 ? 50 : UIScreen.main.bounds.height * 0.1
    }
}

extension InfoManageMentViewController: InfoDelegate {
    func switchDidChange(cell: InfoManageMentTableViewCell) {
        print(cell.switchView.isOn)
        MyUpdateInfo.shared.searchable = cell.switchView.isOn.intValue

    }
    func womanButtonTap(cell: InfoManageMentTableViewCell) {
        MyUpdateInfo.shared.gender = 0
        cell.womanButton.backgroundColor = BrandColor.green
        cell.manButton.backgroundColor = .clear
    }
    func manButtonTap(cell: InfoManageMentTableViewCell) {
        MyUpdateInfo.shared.gender = 1
        cell.manButton.backgroundColor = BrandColor.green
        cell.womanButton.backgroundColor = .clear
    }
    func sliderValueChagend(cell: InfoManageMentTableViewCell) {
        cell.ageRangeLabel.text = "\(Int(cell.slider.value[0])) - \(Int(cell.slider.value[1]))"
        MyUpdateInfo.shared.ageMin = Int(cell.slider.value[0])
        MyUpdateInfo.shared.ageMax = Int(cell.slider.value[1])
    }
    func textFieldChagned(cell: InfoManageMentTableViewCell) {
        print(cell.studyTextField.text!)
        MyUpdateInfo.shared.study = cell.studyTextField.text
    }
    func moreButtonTap() {
        //                cell.moreButton.isSelected.toggle()
        //                self.tableView(self.infoManageView.tableView, heightForRowAt: indexPath)
                    self.infoManageView.tableView.reloadData()
                    print("모어버튼")
    }
    func withdrawButtonTap() {
//        print("회원탈퇴")
         self.withdraw()
    }

}
//
extension InfoManageMentViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    func collectionviewConfigure() {
        infoManageView.collectionview.delegate = self
        infoManageView.collectionview.dataSource = self
    }

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
//            infoManageView.collectionview.backgroundColor = .cyan
            cell.reviewLabel.snp.remakeConstraints { make in
                make.leading.equalTo(10)
                make.top.equalTo(0)
                make.trailing.equalTo(-10)
                make.bottom.equalTo(cell.snp.bottom)
            }
            cell.itemButton.snp.remakeConstraints {$0.width.height.equalTo(0)}
            cell.reviewLabel.frame.size = cell.reviewLabel.intrinsicContentSize
            cell.reviewLabel.text = "첫 리뷰를 기다리는 중이에요!"
            cell.reviewLabel.textColor = Grayscale.gray6
            cell.reviewLabel.layer.borderWidth = 0
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

        switch indexPath.section {
        case 0: return CGSize(width: InfoManageMent.title.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
        case 1:
            return CGSize(width: InfoManageMent.sesacStudy.list[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 40, height: 32)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width   , height: UIScreen.main.bounds.height / 29 )
        default:
            print("오류",#function)
            return CGSize()

        }
    }

}
