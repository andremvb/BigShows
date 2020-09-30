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
import SwiftUI

class ShowPreviewCell: UICollectionViewCell{
    
    private let uuid = UUID().uuidString
    private let nameLabel = UILabel(text: nil, font: .regular(), textColor: .black, numberOfLines: 0)
    private let imageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    
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
        hstack(imageView,
               nameLabel,
               spacing: 5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 234 / 167).isActive = true
        imageView.roundCorners(radius: 4)
        
        imageView.backgroundColor = .init(white: 0.97, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
@available(iOS 13, *)
struct ShowPreviewCellPreview: PreviewProvider {
    static var previews: some View {
        let vm = ShowPreviewViewModel(.fake())
        let cell = ShowPreviewCell()
        cell.showPreview = vm
        return cell.asPreview()
            .previewLayout(.fixed(width: 200, height: 50))
    }
}
#endif
