//
//  HomeEntity.swift
//  MovieApp
//
//  Created by Indra Permana on 29/11/22.
//

import IGListKit

final class HomeEntity: NSObject {
    var items: [MovieSearchResult]
    
    init(items: [MovieSearchResult]) {
        self.items = items
    }
}

extension HomeEntity: ListDiffable {
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return isEqual(object)
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
}
