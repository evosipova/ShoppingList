//
//  ProductsListViewController.swift
//  ShoppingList
//
//  Created by Elizabeth on 28.08.2023.
//

import Foundation
import UIKit

class ProductsListViewController: UIViewController {
    
    private let collectionView = CollectionView()
    private let network: NetworkMainScreen
    private var productsArray = [AdvertisementsResponse.Advertisement]()
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
    
    init() {
        self.network = NetworkFetcher()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        loadGoods()
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    private func loadGoods() {
        Task { @MainActor in
            activityIndicator.startAnimating()
            do {
                productsArray = try await network.getAdvertisements().advertisements
                collectionView.reloadData()
            } catch {
                alert.title = "Ошибка!"
                alert.message = "Не получилось загрузить товары!"
                present(alert, animated: true)
            }
            activityIndicator.stopAnimating()
        }
    }
    
    private func setUpViews() {
        view.backgroundColor = .systemGray5
        view.addSubview(collectionView)
        collectionView.mainVC = self
    }
    
}

extension ProductsListViewController: MainViewControllerProtocol {
    func openDetailVC(index: Int) {
        let productId = productsArray[index].id
        let detailVC = ProductDetailViewController(productId: productId)
        self.present(detailVC, animated: true)
    }
    
    func getAdvertisement(index: Int) -> AdvertisementsResponse.Advertisement {
        productsArray[index]
    }
    
    func getTotalGoods() -> Int {
        productsArray.count
    }
    
}

extension ProductsListViewController {
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
