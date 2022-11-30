//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import RxSwift
import RxRelay

final class HomePresenter: MoviesViewToPresenterProtocol {
    
    var interactor: MoviesPresenterToInteractorProtocol?
    
    var router: MoviesPresenterToRouterProtocol?
    
    var screenState: Observable<ScreenState> {
        screenStateSubject.asObservable()
    }
    
    var movies: [HomeEntity] = []
    
    private var lastQuery = ""
    private var page = 1
    private var screenStateSubject: BehaviorRelay<ScreenState> = .init(value: .initial)
    private var disposeBag = DisposeBag()
    
    func loadMovies(query: String) {
        guard screenStateSubject.value != .loading else { return }
        screenStateSubject.accept(.loading)
        
        if self.lastQuery != query {
            movies = []
        }
        
        interactor?.loadMovies(query: query, page: page)
            .subscribe(onNext: { [weak self] movies in
                
                self?.movies.append(HomeEntity(items: movies))
                
                self?.screenStateSubject.accept(.populated)
            }, onError: { [weak self] error in
                self?.screenStateSubject.accept(.error(errorMessage: error.localizedDescription))
            })
            .disposed(by: disposeBag)
        
        self.lastQuery = query
    }
    
    func loadMoreMovies() {
        guard screenStateSubject.value != .loading else { return }
        screenStateSubject.accept(.loading)
        
        page += 1
        interactor?.loadMovies(query: lastQuery, page: page)
            .subscribe(onNext: { [weak self] movies in
                
                self?.movies.append(HomeEntity(items: movies))
                
                self?.screenStateSubject.accept(.populated)
            }, onError: { [weak self] error in
                self?.screenStateSubject.accept(.error(errorMessage: error.localizedDescription))
            })
            .disposed(by: disposeBag)
        
        self.screenStateSubject.accept(.populated)
    }
    
}

