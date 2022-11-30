//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import UIKit
import IGListKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    
    var presenter: MoviesViewToPresenterProtocol?
    
    private var adapter: ListAdapter?
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.backgroundColor = .lightGray
        view.barTintColor = .lightText
        view.tintColor = .lightGray
        view.placeholder = "Search by Movie Title"
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.isHidden = true
        return view
    }()
    
    private var query = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.title = "Movie App"
        setupView()
        setupBinding()
        presenter?.loadMovies(query: "spiderman")
    }
    
}

extension HomeViewController {
    private func setupView() {
        setupSearchBar()
        setupCollectionView()
        setupLoadingIndicator()
        
    }
    
    private func setupBinding() {
        setupSearchBarBinding()
        setupLoadingObserver()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        adapter.scrollViewDelegate = self
        
        self.adapter = adapter
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupSearchBarBinding() {
        searchBar
            .rx.text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty && $0.count >= 3 }
            .subscribe(
                onNext: { [weak self] query in
                    self?.presenter?.loadMovies(query: query)
                }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupLoadingObserver() {
        presenter?.screenState
            .subscribe (
                onNext: { [weak self] state in
                    guard let self = self else { return }
                    switch state {
                    case .initial:
                        break
                    case .loading:
                        DispatchQueue.main.async {
                            self.loadingIndicator.startAnimating()
                            self.loadingIndicator.isHidden = false
                        }
                    case .error(let errorMessage):
                        DispatchQueue.main.async {
                            print(errorMessage)
                            // TODO: add ErrorView (if offline, or something's wrong with API)
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.isHidden = true
                        }
                        fallthrough
                    case .populated:
                        DispatchQueue.main.async {
                            self.adapter?.performUpdates(animated: true, completion: nil)
                            self.loadingIndicator.stopAnimating()
                            self.loadingIndicator.isHidden = true
                        }
                    }
                }
            )
            .disposed(by: disposeBag)
    }

}

extension HomeViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        presenter?.movies as? [ListDiffable] ?? [ListDiffable]()
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        HomeSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let label = UILabel()
        if let presenter = presenter, presenter.movies.isEmpty {
            label.text = ""
        } else {
            label.text = "No Movie Found :("
        }
        label.textAlignment = .center
        
        return label
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < 200 {
            presenter?.loadMoreMovies()
        }
    }
}
