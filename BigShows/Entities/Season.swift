//
//  Seanson.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/31/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

struct Season: Codable{
    let number: Int
    ///Number of episodes in season
    var episodes: [Episode] = []
}
