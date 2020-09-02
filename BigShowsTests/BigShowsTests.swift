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
    //Test cooret parsing ViewModels
    
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
}
