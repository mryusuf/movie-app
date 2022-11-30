//
//  MovieResponse.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import Foundation

struct MovieResponse: Codable {
    var title: String?
    var year: String?
    var type: String?
    var poster: String?
    var actors: String?
    var plot: String?
}
