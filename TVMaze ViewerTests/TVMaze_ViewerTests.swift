//
//  TVMaze_ViewerTests.swift
//  TVMaze ViewerTests
//
//  Created by Marco Antonio Mayen Hernandez on 1/5/20.
//  Copyright © 2020 Kross. All rights reserved.
//

import XCTest
@testable import TVMaze_Viewer

typealias MockClosure = (() -> ())?

final class MockViewShowsDelegate: ViewShowsDelegate {
    var execute: MockClosure = nil
    var isUpdateMethodCalled = false
    func update(shows: [TVShow]) {
        isUpdateMethodCalled = true
        execute?()
    }
    
}

final class MockViewShowDelegate: ViewShowDelegate {
    var execute: MockClosure = nil
    var isUpdateMethodCalled = false
    
    func update(show: TVShow) {
        isUpdateMethodCalled = true
        execute?()
    }
}


final class TVMaze_ViewerTests: XCTestCase {
    var presenter: ShowsPresenter!
    var mockView: MockViewShowsDelegate!
    var shows: [Shows] = []
    override func setUp() {
        mockView = MockViewShowsDelegate()
        presenter = ShowsPresenter(dependencies: .init(view: mockView))
    }
    
    func test_search_all_shows() {
        var isFulFillComplete = false
        
        let expectation = self.expectation(description: "Loading data")
        presenter.searchMovies("Doctor")
        mockView.execute = {
            isFulFillComplete = true
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(mockView.isUpdateMethodCalled)
        XCTAssert(isFulFillComplete)
        
    }
}

final class ShowPresenterTest: XCTestCase {
    var presenter: ShowPresenter!
    var mockView: MockViewShowDelegate!
    
    override func setUp() {
        mockView = MockViewShowDelegate()
        presenter = ShowPresenter(dependencies: .init(view: mockView))
    }
    
    func test_search_serie_data() {
        var isFulFillComplete = false
        
        let expectation = self.expectation(description: "Loading data")
        presenter.getShowInfo(tvShow: getMockTVShow())
        
        mockView.execute = {
            isFulFillComplete = true
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(mockView.isUpdateMethodCalled)
        XCTAssert(isFulFillComplete)
    }
    
    func getMockTVShow() -> TVShow {
        return TVShow(id: 82, showName: "",
               poster: nil,
               status: "",
               schedule: Schedule(time: "", days: []),
               summary: "",
               genres: [])
    }
}
