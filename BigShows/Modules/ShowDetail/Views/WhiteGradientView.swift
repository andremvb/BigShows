//
//  WhiteGradientView.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit

class WhiteGradientView: UIView{
    
    private let gradientLayer = CAGradientLayer()
    init(){
        super.init(frame: .zero)
        gradientLayer.colors = [UIColor.init(white: 1, alpha: 0).cgColor,
                                UIColor.white.cgColor]
        layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
