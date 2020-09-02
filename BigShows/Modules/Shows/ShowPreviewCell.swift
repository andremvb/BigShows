//
//  ShowPreviewCell.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import LBTATools

class ShowPreviewCell: UICollectionViewCell{
    
    let uuid = UUID().uuidString
    let nameLabel = UILabel(text: nil, font: .regular(), textColor: .black)
    let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
    var showPreview: ShowPreviewViewModel!{
        didSet{
            nameLabel.text = showPreview.name
            imageView.loadImageWithUrl(urlString: showPreview.imageUrl, nameDefault: "Port Default", uuid: uuid)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(named: "Port Default")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let decorator = UIView(backgroundColor: .appYellow).withSize(.init(width: 4, height: 14))
        decorator.roundCorners(radius: 2)
        let topStack = UIView().hstack(decorator, nameLabel, spacing: 8, alignment: .center)
        stack(topStack,
              imageView,
              spacing: 4)
        imageView.roundCorners(radius: 20)
        
        imageView.backgroundColor = .init(white: 0.97, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
