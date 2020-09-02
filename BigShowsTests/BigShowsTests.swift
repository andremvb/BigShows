//
//  BigShowsTests.swift
//  BigShowsTests
//
//  Created by Andre Valdivia on 8/29/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import XCTest
@testable import BigShows

class BigShowsTests: XCTestCase {
    //Test correct creation of ViewModels
    
    class MockShowDetailService: ShowDetailServiceProtocol{
        func fetchShowDetails(id: Int, completion: @escaping (Result<ShowDetail, Error>) -> ()) {}
    }
    
    func test_showDetailViewModel(){
        let showPreview = ShowPreview.init(id: 1, name: "Test name", image: Image(medium: "urlMedium", original: "urlOriginal"))
        let showDetailVM = ShowDetailViewModel(service: MockShowDetailService(), showPreview: showPreview)
        XCTAssertEqual(showDetailVM.name, "Test name")
        XCTAssertEqual(showDetailVM.image?.medium, "urlMedium")
        XCTAssertEqual(showDetailVM.image?.original, "urlOriginal")
        
        let model = ShowDetail(id: 3, name: "Test name 2", image: Image(medium: "medium", original: "original"), schedule: .init(time: "time", days: ["Monday", "Tues"]), genres: ["gnre", "gnre2"], summary: "Test summary")
        showDetailVM.fillWithModel(model)
        XCTAssertEqual(showDetailVM.name, "Test name 2")
        XCTAssertEqual(showDetailVM.image?.medium, "medium")
        XCTAssertEqual(showDetailVM.image?.original, "original")
        XCTAssertEqual(showDetailVM.genres, "gnre, gnre2")
        XCTAssertEqual(showDetailVM.days, "time | Monday, Tues")
        XCTAssertEqual(showDetailVM.summary, "Test summary")
    }
    
    class MockEpisodesService: EpisodesServiceProtocol{
        let episodes: [Episode]
        
        init(_ episodes: Episode...){
            self.episodes = episodes
        }
        
        func fetchsEpisodes(showID: Int, completion: @escaping (Result<[Episode], Error>) -> ()) {
            completion(.success(episodes))
        }
    }
    
    func test_Season(){
        let episode1_1 = Episode(id: 1, name: "Ep1", image: nil, summary: nil, number: 1, season: 1)
        let episode1_2 = Episode(id: 2, name: "Ep2", image: nil, summary: nil, number: 2, season: 1)
        let episode2_1 = Episode(id: 3, name: "Ep1", image: nil, summary: nil, number: 1, season: 2)
        
        let episodesViewModel = EpisodesViewModel(service: MockEpisodesService(episode1_1, episode1_2, episode2_1), showID: 1)
        episodesViewModel.fetchSeasons()
        XCTAssertEqual(episodesViewModel.seasonsViewModel.count, 2)
        XCTAssertEqual(episodesViewModel.seasonsViewModel, [1,2])
        XCTAssertEqual(episodesViewModel.episodesViewModel.count, 2)
        XCTAssertEqual(episodesViewModel.episodesViewModel[0].name, "1. Ep1")
        XCTAssertEqual(episodesViewModel.episodesViewModel[1].name, "2. Ep2")
        
        episodesViewModel.updateEpisodes(index: 1)
        XCTAssertEqual(episodesViewModel.episodesViewModel.count, 1)
        XCTAssertEqual(episodesViewModel.episodesViewModel[0].name, "1. Ep1")
    }
}
