//
//  HomeRouter.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import UIKit

final class HomeRouter: MoviesPresenterToRouterProtocol {
    static func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: MoviesViewToPresenterProtocol = HomePresenter()
        
        let interactor = HomeInteractor()
        
        presenter.interactor = interactor
        viewController.presenter = presenter
//        viewController.presenter?.router = QuotesRouter()
        
        
        return navigationController
    }
    
    
}
