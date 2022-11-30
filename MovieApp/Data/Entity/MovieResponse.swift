//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let search: [MovieSearchResult]?
    let totalResults, response: String?

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct MovieSearchResult: Codable {
    let title, year, imdbID, type: String?
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
