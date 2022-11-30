//
//  MovieResponseMock.swift
//  MovieAppTests
//
//  Created by Indra Permana on 30/11/22.
//
@testable import MovieApp
import Foundation

struct MovieResponseMock {
    static let jsonData = """
    {
        "Search": [
            {
                "Title": "Black Panther: Wakanda Forever",
                "Year": "2022",
                "imdbID": "tt9114286",
                "Type": "movie",
                "Poster": "https://m.media-amazon.com/images/M/MV5BNTM4NjIxNmEtYWE5NS00NDczLTkyNWQtYThhNmQyZGQzMjM0XkEyXkFqcGdeQXVyODk4OTc3MTY@._V1_SX300.jpg"
            }
        ],
        "totalResults": "1",
        "Response": "True"
    }

    """
    
    static func makeMovieResponse() -> MovieResponse {
        let data = Data(MovieResponseMock.jsonData.utf8)
        return try! JSONDecoder().decode(MovieResponse.self, from: data)
    }
}
