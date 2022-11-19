//
//  TapViewController.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/16.
//

import UIKit

final class TapViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.unselectedItemTintColor = Grayscale.gray6
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = BrandColor.green
        self.navigationController?.isNavigationBarHidden = true
        let firstVC = UINavigationController(rootViewController: HomeViewController())
        firstVC.tabBarItem.title = "홈"
        firstVC.tabBarItem.image = UIImage(named: "home_black_icon.png")
        
        let secondVC =  UINavigationController(rootViewController: SesacShopViewController())
        secondVC.tabBarItem.title = "새싹샵"
        secondVC.tabBarItem.image = UIImage(named: "present_black_icon.png")
        
        let thirdVC = UINavigationController(rootViewController: SesacFriendViewController())
        thirdVC.tabBarItem.title = "새싹친구"
        thirdVC.tabBarItem.image = UIImage(named: "sesac_black_icon.png")
        
        
        
        let fourVC = UINavigationController(rootViewController: MyInfoViewController())
        fourVC.tabBarItem.title = "내정보"
        fourVC.tabBarItem.image = UIImage(named: "person_black_icon.png")
        
        viewControllers = [firstVC, secondVC, thirdVC, fourVC]
        
    }
    


}
