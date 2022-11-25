//
//  ButtonProtocol.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/11/26.
//

import UIKit

@objc protocol ButtonProtocol {
    @objc optional func chagedPlotingButton(imageName: String, button: UIButton)
}

extension ButtonProtocol {
    func chagedPlotingButton(imageName: String, button: UIButton)  {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .light)
        let image = UIImage(systemName: imageName , withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
    }
}
