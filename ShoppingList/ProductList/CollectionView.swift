//
//  CollectionView.swift
//  ShoppingList
//
//  Created by Elizabeth on 31.08.2023.
//

import Foundation
import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func getTotalGoods() -> Int
    func getAdvertisement(index: Int) -> AdvertisementsResponse.Advertisement
    func openDetailVC(index: Int)
}

class CollectionView: UICollectionView {
    
    weak var mainVC: MainViewControllerProtocol?
    
    private let collectionLayout = UICollectionViewFlowLayout()
    
    private let idCell = "collectionCell"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: collectionLayout)
        
        configure()
        setUpLayout()
        register(ProductCell.self, forCellWithReuseIdentifier: idCell)
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
         collectionLayout.minimumInteritemSpacing = 7
    }
    
    private func configure() {
        collectionLayout.scrollDirection = .vertical
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        backgroundColor = .none
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
}

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainVC?.getTotalGoods() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell, for: indexPath) as? ProductCell,
              let mainVC = mainVC else {return UICollectionViewCell()}
        cell.configure(with: mainVC.getAdvertisement(index: indexPath.item))
        return cell
    }
}

extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.06,
               height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainVC?.openDetailVC(index: indexPath.item)
    }
}
