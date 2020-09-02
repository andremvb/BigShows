//
//  EpisodeCell.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation
import UIKit
import LBTATools
import SwiftUI

class EpisodeCell: UITableViewCell{
    let uuid = UUID().uuidString
    
    private let portraitImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    private let nameLabel = UILabel(text: nil, font: .bold(), textColor: .black, numberOfLines: 0)
    private let summaryLabel = UILabel(text: nil, font: .regular(10), textColor: .gray, numberOfLines: 0)
    
    func setupCell(_ episode: EpisodeCellViewModel) {
        nameLabel.text = episode.name
        summaryLabel.text = episode.summary
        portraitImageView.loadImageWithUrl(urlString: episode.imageURL, nameDefault: "Port Default", uuid: uuid)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        //ImageView
        portraitImageView.roundCorners(radius: 8)
        portraitImageView.heightAnchor.constraint(equalTo: portraitImageView.widthAnchor, multiplier: 234 / 167).isActive = true
        
        //Setup all view
        hstack(portraitImageView.withWidth(65),
               UIView().stack(nameLabel, summaryLabel),
               spacing: 12,
               alignment: .center).withMargins(.allSides(8))
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#if DEBUG
@available(iOS 13, *)
struct EpisodeCellPreview: PreviewProvider {
    static var previews: some View {
        let cell = EpisodeCell(style: .default, reuseIdentifier: nil)
        cell.setupCell(.init(.fake()))
        return cell.border(width: 1, color: .init(white: 0.8, alpha: 1))
            .asPreview()
            .previewLayout(.fixed(width: 414, height: 200))
            .padding()
    }
}
#endif
