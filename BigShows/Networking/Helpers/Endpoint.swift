//
//  Endpoint.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

struct Endpoint{
    var path: String
    var queryItems: [URLQueryItem] = []
    
    var url: URL{
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.tvmaze.com"
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else{
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension Endpoint{
    static func fetchShows(_ query: String) -> Self{
        .init(path: "/search/shows",
              queryItems: [URLQueryItem(name: "q", value: query)])
    }
    
    static func show(_ showId: Int) -> Self{
        .init(path: "/shows/\(showId)")
    }
    
    static func seasons(_ showId: Int) -> Self{
        .init(path: "/shows/\(showId)/seasons")
    }
    
    static func episodes(seasonId: Int) -> Self{
        .init(path: "/seasons/\(seasonId)/episodes")
    }
    
    static func episodes(showId: Int) -> Self{
        .init(path: "/shows/\(showId)/episodes")
    }
}
