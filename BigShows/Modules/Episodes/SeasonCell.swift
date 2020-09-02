//
//  SeasonCell.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import LBTATools

class SeasonCell: UICollectionViewCell{
    
    private let seasonLabel = UILabel(text: nil, font: .black(), textColor: .black, textAlignment: .center, numberOfLines: 1)
    
    private let selectedColor = UIColor.appRose
    private let unselectedColor = UIColor.init(white: 0.95, alpha: 1)
    
    func setupCell(number: Int){
        seasonLabel.text = String(number)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(seasonLabel)
        seasonLabel.fillSuperview()
        seasonLabel.roundCorners(radius: 8)
        seasonLabel.backgroundColor = unselectedColor
        seasonLabel.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                seasonLabel.backgroundColor = selectedColor
                seasonLabel.textColor = .white
            }else{
                seasonLabel.backgroundColor = unselectedColor
                seasonLabel.textColor = .black
            }
        }
    }
}
