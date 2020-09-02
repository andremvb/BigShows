//
//  EpisodesService.swift
//  BigShows
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

class EpisodesService: EpisodesServiceProtocol{
    
    let client = HTTPClient()
    
    func fetchsEpisodes(showID: Int, completion: @escaping (Result<[Episode],Error>) -> ()){
        client.get(endPoint: .episodes(showId: showID)) { (result) in
            switch result{
            case let .success((data, _)):
                do{
                    let episodes = try JSONDecoder().decode([Episode].self, from: data)
                    completion(.success(episodes))
                }catch{
                    completion(.failure(ServiceError.decode))
                }
            case .failure(_):
                completion(.failure(ServiceError.connectivity))
            }
        }
    }
}
