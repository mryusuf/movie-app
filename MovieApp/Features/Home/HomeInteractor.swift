//
//  HomeInteractor.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import RxSwift

final class HomeInteractor: MoviesPresenterToInteractorProtocol {
    
    private var repository: MovieRepositoryProtocol
    private var disposeBag = DisposeBag()

    init(repository: MovieRepositoryProtocol = MovieRepository()) {
        self.repository = repository
    }
    
    func loadMovies(query: String, page: Int) -> Observable<[MovieSearchResult]> {
        return Observable<[MovieSearchResult]>.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            
            self.repository.fetchData(query: query, page: page)
                .subscribe(onNext: { data in
                    print(data)
                    observer.onNext(data.search ?? [])
                    observer.onCompleted()
                }, onError: { error in
                    observer.onError(error)
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
    }
    
    
}
