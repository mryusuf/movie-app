//
//  MovieRepositoryMock.swift
//  MovieAppTests
//
//  Created by Indra Permana on 30/11/22.
//
@testable import MovieApp
import RxSwift

final class MovieRepositoryMock: MovieRepositoryProtocol {
    
    var movieResponse: MovieResponse
    
    init(movieResponse: MovieResponse) {
        self.movieResponse = movieResponse
    }
    
    func fetchData(query: String, page: Int) -> Observable<MovieResponse> {
        Observable.just(movieResponse)
    }
    
}
