//
//  CheaperStoresView.swift
//  GameDeals
//
//  Created by Five on 08.06.2022..
//

import Foundation
import UIKit
import SnapKit


class CheaperStoresView: UIView {
    private let cellIdentifier = "cellId"
    let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    private var data: [DealCheaperStore] = []
    private var shopData: [Int: Shop] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    convenience init() {
        self.init(frame: .zero)
        buildViews()
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func buildViews() {
        addSubview(collectionView)
        backgroundColor = .clear

        collectionView.register(CheaperStoresCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .clear
        self.layoutIfNeeded()
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {make in
            make.leading.bottom.top.trailing.equalToSuperview()
        }
    }
    
    func getCollectionViewContentHeight() -> CGFloat {
        return collectionView.contentSize.height
    }
    
    func loadData(cheaperStores: [DealCheaperStore]) {
        self.data = cheaperStores
        collectionView.reloadData()
    }
    
    func loadShopsData(shops: [Shop]) {
        shops.forEach { shop in
            self.shopData[shop.storeID] = shop
        }
        collectionView.reloadData()
    }
}

extension CheaperStoresView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as! CheaperStoresCell
        cell.setup(cheaperStoreData: data[indexPath.row], shop: shopData[Int(data[indexPath.row].storeID) ?? 0])
            
        return cell
    }
}

extension CheaperStoresView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
