//
//  OnBoardingView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/10.
//

import UIKit

class OnBoardingView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    let vc1 = FirstViewController()
    let vc2 = SecondViewController()
    let vc3 = ThirdViewController()
    
    lazy var viewControllersArray: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("버튼 시작", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    
    lazy var pageControl: UIPageControl = {
        let pageControl: UIPageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = 0
        
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .systemGray5
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    override func configure() {
        
        
        [pageViewController.view,pageControl,startButton].forEach {
            self.addSubview($0)
        }
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top).offset(-20)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageViewController.view.snp.bottom)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(60)
        }
        
        startButton.snp.makeConstraints { make in
            //            make.top.equalTo(pageControl.snp.bottom).offset(50)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-70)
            make.top.equalTo(pageControl.snp.bottom).offset(15)
        }
        
    }
    
}
