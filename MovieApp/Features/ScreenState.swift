//
//  ScreenState.swift
//  MovieApp
//
//  Created by Indra Permana on 30/11/22.
//

import Foundation

enum ScreenState: Equatable {
    case initial
    case loading
    case populated
    case error(errorMessage: String)
}
