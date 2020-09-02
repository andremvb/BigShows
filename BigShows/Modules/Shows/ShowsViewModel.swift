//
//  ShowsViewModel.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation


class ShowPreviewViewModel{
    let name: String
    let imageUrl: String?
    init(_ show: ShowPreview){
        self.name = show.name
        self.imageUrl = show.image?.medium
    }
    
    static func fake() -> ShowPreviewViewModel{
        .init(.fake())
    }
}

protocol ShowsNavigator {
    func goToShowDetail(_ show: ShowPreview)
}

class ShowsViewModel{
    
    typealias ShowsLoader = (String, @escaping (Result<[ShowPreview], Error>) -> ()) -> ()
    typealias Navigate = (ShowPreview) -> ()
    
    let loader: ShowsLoader
    private let navigate: Navigate
    
    var showsViewModel: [ShowPreviewViewModel] = []
    var didUpdate: (() -> ())?
    
    private var showsPreview: [ShowPreview] = []{
        didSet{
            showsViewModel = showsPreview.map{ShowPreviewViewModel($0)}
            didUpdate?()
        }
    }
    
    init(loader: @escaping ShowsLoader, navigate: @escaping Navigate){
        self.loader = loader
        self.navigate = navigate
    }
    
    func fetchShows(_ query: String){
        showsPreview = showsPreview.filter({ (show) -> Bool in
            show.name.contains(query)
        })
        loader(query){ result in
            switch result{
            case .success(let showsPreview):
                self.showsPreview = showsPreview
            case .failure(_):
                break //Do something
            }
        }
    }
    
    func tapedShow(index: Int){
        navigate(showsPreview[index])
    }
}
