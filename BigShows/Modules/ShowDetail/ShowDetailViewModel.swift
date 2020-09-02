//
//  ShowDetailViewModel.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/31/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

protocol ShowDetailServiceProtocol{
    func fetchShowDetails(id: Int, completion: @escaping (Result<ShowDetail, Error>) -> ())
}

class ShowDetailViewModel{
    
    private let service: ShowDetailServiceProtocol
    private let showid: Int
    private let showPreview: ShowPreview
    
    ///Called once fetchShowDetails gets data
    var updateDetails: (() -> ())?
    
    var name: String
    var image: Image?
    var summary: String?
    var genres: String?
    var days: String?
    
    
    init(service: ShowDetailServiceProtocol, showPreview: ShowPreview){
        self.service = service
        self.showPreview = showPreview
        self.showid = showPreview.id
        self.name = showPreview.name
        self.image = showPreview.image
    }
    
    
    ///Fetch shows details
    func fetchShowDetail(){
        service.fetchShowDetails(id: showid){ result in
            switch result{
            case .success(let detail):
                self.fillWithModel(detail)
                DispatchQueue.main.async {
                    self.updateDetails?()
                }
            case .failure(let error):
                //TODO: Handle error
                print(error)
            }
        }
    }
    
    func fillWithModel(_ showDetail: ShowDetail){
        self.name = showDetail.name
        self.image = showDetail.image
        self.summary = showDetail.summary?.withoutHtmlTags
        self.genres = showDetail.genres.joined(separator: ", ")
        self.days = showDetail.schedule.time  + " | " + showDetail.schedule.days.joined(separator: ", ") 
    }
    
}
