//
//  Endpoint.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import Alamofire

struct API {
    static let baseURL = "http://www.omdbapi.com/"
    static let apiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
}

protocol Endpoint {
    var url: String { get }
    var httpMethod: HTTPMethod { get }
}

enum Endpoints: Endpoint {
    case movie
    
    var url: String {
        switch self {
        case .movie:
            return "\(API.baseURL)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
