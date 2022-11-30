//
//  HomeSectionController.swift
//  MovieApp
//
//  Created by Indra Permana on 28/11/22.
//

import IGListKit
import Lightbox

final class HomeSectionController: ListSectionController {
    
    var model: HomeEntity?
    
    override init() {
        super.init()
        
        inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    override func numberOfItems() -> Int {
        model?.items.count ?? 0
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        if let cell = collectionContext?.dequeueReusableCell(of: MovieCollectionViewCell.self, for: self, at: index) as? MovieCollectionViewCell,
           let model = model {
            cell.delegate = self
            cell.configure(with: model.items[index])

            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        if let collectionContext = collectionContext {
            return CGSize(width: (collectionContext.containerSize.width - 40) / 2, height: 250)
        }
        
        return CGSize(width: 250, height: 250)
    }
    
    override func didUpdate(to object: Any) {
        self.model = object as? HomeEntity
    }
}

extension HomeSectionController: ImagePreviewProtocol {
    func onImageViewTapped(with image: UIImage) {
        let image = [LightboxImage(image: image)]

        if let viewController = viewController {
            let lightBoxController = LightboxController(images: image, startIndex: 0)
            lightBoxController.pageDelegate = self as LightboxControllerPageDelegate
            lightBoxController.dismissalDelegate = self as LightboxControllerDismissalDelegate
            lightBoxController.dynamicBackground = true
            lightBoxController.title = viewController.title

            viewController.present(lightBoxController, animated: true, completion: nil)
        }
    }
}


extension HomeSectionController: LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
  
  func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
    
  }
  
  func lightboxControllerWillDismiss(_ controller: LightboxController) {
    
  }
  
}
