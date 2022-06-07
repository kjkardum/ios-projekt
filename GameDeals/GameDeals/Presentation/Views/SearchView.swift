//
//  RecommendedView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//

//
//  RecommendedView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//


import Foundation
import UIKit
import SnapKit


class SearchView: UIView, LikeDealDelegate {
    func likeDeal(dealId: String, like: Bool) {
        likeDealDelegate?.likeDeal(dealId: dealId, like: like)
    }
    
    private let cellIdentifier2 = "cellId2"
    private let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    var dealsData : [Deal] = []
    weak var likeDealDelegate: LikeDealDelegate?
    
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
        collectionView.register(RecommendedCell.self, forCellWithReuseIdentifier: cellIdentifier2)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = .clear
    }
    
    
    private func setLayout() {
        collectionView.snp.makeConstraints {make in
            make.leading.bottom.top.trailing.equalToSuperview()
        }
    }
    
    func loadData(dealsData: [Deal]) {
        self.dealsData = dealsData
        collectionView.reloadData()
    }
}

extension SearchView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dealsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier2,
                for: indexPath) as! RecommendedCell
        
        cell.setup(dealData: dealsData[indexPath.row])
        cell.likeDealDelegate = self
            
        return cell
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
