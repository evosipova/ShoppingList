//
//  ProductCell.swift
//  ShoppingList
//
//  Created by Elizabeth on 28.08.2023.
//


import Foundation
import UIKit

class ProductCell: UICollectionViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var productImageView: WebImageView = {
        let image = WebImageView()
        image.contentMode = .center
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.translatesAutoresizingMaskIntoConstraints = false
        let configuration = UIImage.SymbolConfiguration(textStyle: .callout)
        image.image = UIImage(systemName: "questionmark")?.withConfiguration(configuration)
        return image
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
    }
    
    func configure(with product: AdvertisementsResponse.Advertisement) {
        titleLabel.text = product.title
        priceLabel.text = product.price
        locationLabel.text = product.location
        dateLabel.text = product.createdDate
        productImageView.setIcon(product.imageURL)
    }
    

    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
        ])
    }
}
