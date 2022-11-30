//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import Alamofire
import RxSwift

protocol MovieRepositoryProtocol {
    func fetchData(query: String, page: Int) -> Observable<MovieResponse>
}

struct MovieRepository: MovieRepositoryProtocol {
    
    var endpoint: Endpoint
    
    init(endpoint: Endpoint = Endpoints.movie) {
        self.endpoint = endpoint
    }
    
    func fetchData(query: String = "", page: Int = 1) -> Observable<MovieResponse> {
        return Observable<MovieResponse>.create { observer in
            if let url = URL(string: endpoint.url) {
                AF.request(
                    url,
                    method: endpoint.httpMethod,
                    parameters: [
                        "apikey": API.apiKey,
                        "s": query,
                        "page": page
                    ]
                )
                    .validate()
                    .responseDecodable(of: MovieResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
