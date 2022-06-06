//
//  DealsView.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import UIKit
import SnapKit


class DealsView: UIView {
    private let cellIdentifier = "cellId"
    private let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    var dealsData: [Deal] = []
    var shops: [Int: Shop] = [:]
    weak var likeDealDeleage: LikeDealDeleage?
    
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
        collectionView.backgroundColor = .clear
        collectionView.register(DealCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    
    private func setLayout() {
        collectionView.snp.makeConstraints {make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func loadData(dealsData: [Deal], shops: [Shop]) {
        self.dealsData = dealsData
        shops.forEach { shop in
            self.shops[shop.storeID] = shop
        }

        collectionView.reloadData()
    }
    
    func resetCollectionViewPosition() {
        collectionView.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
}

extension DealsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dealsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as! DealCell
        
        cell.setup(dealData: dealsData[indexPath.row], shopData: shops[dealsData[indexPath.row].storeID])
        cell.scrollViewDelegate = self
        cell.likeDealDelegate = self
            
        return cell
    }
}

extension DealsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension DealsView: ScrollableCollectionViewDelegate {
    func setScrollViewEnabled(_ enabled: Bool) {
        collectionView.isScrollEnabled = enabled
    }
}


extension DealsView: LikeDealDeleage {
    func likeDeal(dealId: String, like: Bool) {
        likeDealDeleage?.likeDeal(dealId: dealId, like: like)
    }
}
