//
//  StringTests.swift
//  BigShowsTests
//
//  Created by Andre Valdivia on 9/1/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import XCTest
@testable import BigShows

class StringTests: XCTest{
    func test_remoedHTML(){
        let original = "<p>Hola mundo</p>"
        XCTAssertEqual(original.withoutHtmlTags, "Hola mundo")
    }
}
