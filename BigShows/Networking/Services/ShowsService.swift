//
//  ShowsService.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

class ShowsService{
    
    class ShowWrapper: Codable{
        let show: ShowPreview
    }
    
    private let client: HTTPClient = HTTPClient()
    
    func fetchShows(_ query: String, completion: @escaping (Result<[ShowPreview], Error>) -> ()){
        client.get(endPoint: .fetchShows(query)) { (result) in
            if case let .success((data, _)) = result{
                do {
                    let shows = try JSONDecoder().decode([ShowWrapper].self, from: data)
                    completion(.success(shows.map{$0.show}))
                } catch {
                    print(error)
                    completion(.failure(ServiceError.decode))
                }
            }else{
                completion(.failure(ServiceError.connectivity))
            }
        }
    }
    
}

extension ShowsService: ShowDetailServiceProtocol{
    func fetchShowDetails(id: Int, completion: @escaping (Result<ShowDetail, Error>) -> ()) {
        client.get(endPoint: .show(id)) { (result) in
            if case let .success((data, _)) = result{
                do {
                    let show = try JSONDecoder().decode(ShowDetail.self, from: data)
                    completion(.success(show))
                } catch {
                    print(error)
                    completion(.failure(ServiceError.decode))
                }
            }else{
                completion(.failure(ServiceError.connectivity))
            }
        }
    }
}


