//
//  ProductDetailViewController.swift
//  ShoppingList
//
//  Created by Elizabeth on 28.08.2023.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    private var product: AdvertisementDetail?
    var productId: String
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var productImageView: WebImageView!
    private var nameLabel: UILabel!
    private var priceLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var emailLabel: UILabel!
    private var phoneNumberLabel: UILabel!
    private var addressLabel: UILabel!
    private var descriptionTitleLabel: UILabel!
    private var network: NetworkDetailScreen
    
    private let activityIndicator: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            return activityIndicator
        }()
    
    private let alert: UIAlertController = {
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            return alert
        }()
    
    init(productId: String) {
        self.productId = productId
        self.network = NetworkFetcher()
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemGray5
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getItem()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func getItem() {
        Task { @MainActor in
            activityIndicator.startAnimating()
            do {
                product = try await network.getAdvertisement(id: productId)
                setupUI()
            } catch {
                alert.title = "Ошибка!"
                alert.message = "Не получилось загрузить товар!"
                present(alert, animated: true)
            }
            activityIndicator.stopAnimating()
        }
    }
    
    private var descriptionContainerView: UIView!
    
    private func setupUI() {
        scrollView = UIScrollView()
        contentView = UIView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        productImageView = WebImageView()
        productImageView.setIcon(product?.imageURL)
        nameLabel = UILabel()
        priceLabel = UILabel()
        descriptionLabel = UILabel()
        emailLabel = UILabel()
        phoneNumberLabel = UILabel()
        addressLabel = UILabel()
        
        descriptionLabel.numberOfLines = 0
        
        descriptionContainerView = UIView()
        descriptionContainerView.layer.cornerRadius = 10
        descriptionContainerView.layer.borderWidth = 2
        descriptionContainerView.layer.borderColor = UIColor.black.cgColor
        descriptionContainerView.backgroundColor = UIColor.systemFill
        descriptionContainerView.clipsToBounds = true
        
        contentView.addSubview(descriptionContainerView)
        descriptionContainerView.translatesAutoresizingMaskIntoConstraints = false
        descriptionContainerView.addSubview(descriptionLabel)
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.layer.cornerRadius = 20
        productImageView.clipsToBounds = true
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        nameLabel.text = product?.title
        
        priceLabel.textColor = UIColor.lightText
        priceLabel.font = UIFont.systemFont(ofSize: 18)
        priceLabel.numberOfLines = 0
        priceLabel.text = product?.price
        descriptionLabel.text = product?.description
        emailLabel.text = product?.email
        emailLabel.textColor = UIColor.lightText
        phoneNumberLabel.text = product?.phoneNumber
        phoneNumberLabel.textColor = UIColor.lightText
        addressLabel.text = product?.address
        addressLabel.textColor = UIColor.lightText
        
        descriptionTitleLabel = UILabel()
        descriptionTitleLabel.text = "Описание"
        descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(descriptionTitleLabel)
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(addressLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            descriptionContainerView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            descriptionContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainerView.bottomAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -10),
            
        ])
        
    }
}
