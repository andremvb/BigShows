//
//  Show.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

struct ShowPreview: Codable, Identifiable, CustomStringConvertible{
    var description: String{
        return "Name: \(name)"
    }
    
    let id: Int
    let name: String
    let image: Image?
    
    init(id: Int, name: String, image: Image) {
        self.id = id
        self.name = name
        self.image = image
    }
    
    static func fake() -> ShowPreview{
        .init(id: 1, name: "Test Show", image: .fake())
    }
}
