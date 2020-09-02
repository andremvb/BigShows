//
//  EpisodeDetail.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/31/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

struct EpisodeDetail {
    /*
     name
     number
     season
     summary
     image (optional)
     */
    
    let id: Int
    let name: String
    let season: Int
    let number: Int?
    let image: Image?
    let summary: String?
}
