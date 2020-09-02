//
//  Episode.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/31/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

struct Episode: Codable{
    
    let id: Int
    let name: String
    let image: Image?
    let summary: String?
    let number: Int
    let season: Int
    
    static func fake() -> Episode{
        Episode(id: 1,
                name: "Losing It: Our Mental Health Emergency",
                image: .fake(),
                summary: "<p>As attitudes to mental health change during a surge in the number of people asking for help or harming themselves, this series joins the frontline care services in Nottinghamshire.</p>",
                number: 1,
                season: 1)
    }
}
