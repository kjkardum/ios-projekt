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
    private let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumInteritemSpacing = 7
        flowlayout.minimumLineSpacing = 30
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    var dealsData : [TestData] = []
    
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
        backgroundColor = .white
        collectionView.register(DealCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
    }
    
    
    private func setLayout() {
        collectionView.snp.makeConstraints {make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(200)
            make.width.equalToSuperview()
            make.height.equalTo(400) // MARK: NE
        }
    }
    
    func loadData(dealsData: [TestData]) {
        self.dealsData = dealsData
        collectionView.reloadData()
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
        
        cell.setup(dealData: dealsData[indexPath.row])
            
        return cell
    }
}

extension DealsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width-30, height: collectionView.frame.size.height)
    }
}
