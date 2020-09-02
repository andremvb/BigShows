//
//  EpisodeCelViewModel.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

class EpisodeCellViewModel{
    
    let imageURL: String?
    let name: String
    let summary: String?
    
    init(_ episode: Episode){
        self.imageURL = episode.image?.medium
        self.name = "\(episode.number). \(episode.name)"
        self.summary = episode.summary?.withoutHtmlTags
    }
    
    static func fake() -> EpisodeCellViewModel{
        .init(.fake())
    }
}
