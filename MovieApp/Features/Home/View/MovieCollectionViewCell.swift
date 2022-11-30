//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Indra Permana on 26/11/22.
//

import UIKit
import SDWebImage

protocol ImagePreviewProtocol: AnyObject {
    func onImageViewTapped(with image: UIImage)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ImagePreviewProtocol?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width)).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0;
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .top
        stackView.distribution = .equalSpacing
        [imageView, titleLabel].forEach { view in stackView.addArrangedSubview(view)
        }
        titleLabel.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: (contentView.bounds.width)).isActive = true
        return stackView
    }()
    
    override func layoutSubviews() {
        
        self.backgroundColor = UIColor.white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with movie: MovieSearchResult) {
        
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        imageView.sd_imageIndicator = SDWebImageProgressIndicator.default
        imageView.sd_setImage(with: URL(string: movie.poster ?? ""), placeholderImage: UIImage(named: "movie_placeholder"))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(
          UITapGestureRecognizer(target: self, action: #selector(self.onImageViewTapped))
        )
        
        titleLabel.text = movie.title ?? ""
    }
    
    @objc func onImageViewTapped() {
        guard let image: UIImage = self.imageView.image else { return }
        self.delegate?.onImageViewTapped(with: image)
    }
}
