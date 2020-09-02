//
//  HTTPClient.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

class HTTPClient{
    
    enum HTTPClientError: Error{
        case invalidData
    }
    
    /** URLSession wrapper.
     Also checks if statusCode of URLSessionResponse == 200.
    */
    func get(endPoint: Endpoint, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> ()){
        URLSession.shared.dataTask(with: endPoint.url) { (data, urlResponse, error) in
            guard error == nil else{
                completion(.failure(error!))
                return
            }
            guard let data = data,
                let urlResponse = urlResponse as? HTTPURLResponse,
                urlResponse.statusCode == 200 else{
                completion(.failure(HTTPClientError.invalidData))
                return
            }
            completion(.success((data, urlResponse)))
        }.resume()
    }
    
    
}
