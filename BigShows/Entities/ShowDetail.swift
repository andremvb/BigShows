//
//  ShowDetail.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

struct ShowDetail: Codable{
    
    struct Schedule: Codable{
        let time: String
        let days: [String]
    }
    
    let id: Int
    let name: String
    let image: Image?
    let schedule: Schedule
    let genres: [String]
    let summary: String?
    
}
