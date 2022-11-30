//
//  MovieResponseTest.swift
//  MovieAppTests
//
//  Created by Indra Permana on 30/11/22.
//
@testable import MovieApp
import XCTest

final class MovieResponseTest: XCTestCase {
    var sut: MovieResponse!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = MovieResponseMock.makeMovieResponse()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testCardsResponse() throws {
        XCTAssertTrue((sut as Any) is Decodable)
        XCTAssertEqual(sut.search?.count, 1)
        XCTAssertEqual(sut.totalResults, "1")

        let movie = sut.search!.first

        XCTAssertEqual(movie?.imdbID, "tt9114286")
        XCTAssertEqual(movie?.title, "Black Panther: Wakanda Forever")
        XCTAssertEqual(movie?.poster, "https://m.media-amazon.com/images/M/MV5BNTM4NjIxNmEtYWE5NS00NDczLTkyNWQtYThhNmQyZGQzMjM0XkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_SX300.jpg")
        
    }

}
