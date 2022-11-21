//
//  HomeView.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/07.
//

import Foundation
import NMapsMap
import SnapKit
class HomeView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstrains()
    }
    
    lazy var naverMapView: NMFNaverMapView = {
        let naverMapview = NMFNaverMapView(frame: self.frame)
        naverMapview.showLocationButton = false
        naverMapview.mapView.zoomLevel = 10
        naverMapview.showCompass = false
        naverMapview.showZoomControls = false
        return naverMapview
    }()
    lazy var locationBtn: UIButton = {
        let bt = UIButton()
        let image = UIImage(named: "bt_gps.png", variableValue: 1)
        bt.setImage(image, for: .normal)
        return bt
    }()
    lazy var allBtn: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = BrandColor.green
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("전체", for: .normal)
        bt.setTitleColor(BlackWhite.white, for: .normal)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 10
        bt.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        bt.layer.shadowColor = UIColor.gray.cgColor
        bt.layer.shadowOpacity = 1.0
        bt.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bt.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        
        return bt
    }()
    
    lazy var manFilterBtn: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = BlackWhite.white
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.setTitle("남자", for: .normal)
        return bt
    }()
    lazy var womanFilterBtn: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = BlackWhite.white
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("여자", for: .normal)
        bt.setTitleColor(BlackWhite.black, for: .normal)
        bt.clipsToBounds = true
        bt.layer.cornerRadius = 10
        bt.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        //MARK: 그림자
        bt.layer.shadowColor = UIColor.gray.cgColor
        bt.layer.shadowOpacity = 0.5
        bt.layer.shadowRadius = 10
        bt.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        bt.layer.shadowOffset = CGSize(width: 20, height: 15)
        
        return bt
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
//        stackView.backgroundColor = .blue
        return stackView
    }()
    
    lazy var searchBtn: UIButton = {
        let bt = UIButton()
        bt.backgroundColor = .clear
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
        let image = UIImage(systemName: "magnifyingglass.circle.fill", withConfiguration: imageConfig)
        bt.setImage(image, for: .normal)
        bt.tintColor = BlackWhite.black
        return bt
    }()
    
    
    
    
    override func configure() {
        [naverMapView,locationBtn,stackView,searchBtn].forEach {
            self.addSubview($0)
        }
        [allBtn,manFilterBtn,womanFilterBtn].forEach {
            self.stackView.addArrangedSubview($0)
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0).isActive = true
        }
        

    }
    override func setConstrains() {
        naverMapView.snp.makeConstraints { $0.edges.equalTo(0)}
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(UIScreen.main.bounds.height * 0.1)
            make.leading.equalTo(UIScreen.main.bounds.width * 0.05)
            make.width.equalTo(50)
            make.height.equalTo(UIScreen.main.bounds.height * 0.2)
        }
        
        locationBtn.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(stackView.snp.leading)
            make.height.equalTo(UIScreen.main.bounds.width * 0.15)
            make.trailing.equalTo(stackView.snp.trailing)
        }
        searchBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-(UIScreen.main.bounds.width * 0.05))
            make.bottom.equalTo(-(UIScreen.main.bounds.height * 0.03))
            make.width.height.equalTo(UIScreen.main.bounds.height * 0.08)
        }
    }
    
}


