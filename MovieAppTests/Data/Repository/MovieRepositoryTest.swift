//
//  MovieRepositoryTest.swift
//  MovieAppTests
//
//  Created by Indra Permana on 30/11/22.
//
@testable import MovieApp
import XCTest
import RxSwift
import RxBlocking

final class MovieRepositoryTest: XCTestCase {
    
    var sut: MovieRepositoryProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = MovieRepositoryMock(movieResponse: MovieResponseMock.makeMovieResponse())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchData() throws {
        let movieResponse = MovieResponseMock.makeMovieResponse()
        
        XCTAssertEqual(try sut.fetchData(query: "", page: 1).toBlocking().first()?.totalResults, movieResponse.totalResults)
    }

}

