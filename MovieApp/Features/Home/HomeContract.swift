//
//  HomeContract.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import UIKit
import RxSwift


// MARK: View Input (View -> Presenter)
protocol MoviesViewToPresenterProtocol: AnyObject {
    
    var interactor: MoviesPresenterToInteractorProtocol? { get set }
    var router: MoviesPresenterToRouterProtocol? { get set }
    var screenState: Observable<ScreenState> { get }
    var movies: [HomeEntity] { get }
    
    func loadMovies(query: String)
    
    func loadMoreMovies()

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol MoviesPresenterToInteractorProtocol: AnyObject {
    
    func loadMovies(query: String, page: Int) -> Observable<[MovieSearchResult]>
}


// MARK: Router Input (Presenter -> Router)
protocol MoviesPresenterToRouterProtocol: AnyObject {
    
    static func createModule() -> UINavigationController

}
