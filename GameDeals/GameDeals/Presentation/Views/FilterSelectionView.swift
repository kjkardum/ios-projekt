//
//  FilterSelectionView.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit


class FilterSelectionView: UIView {
    private let cellIdentifier = "cellId"
    private let collectionView : UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .horizontal
        flowlayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
    }()
    private var data : [String] = []
    
    private var selectedData: [Int: Bool] = [:]
    
    private var lastSelected : Int?
    
    private var isMultiselect = true
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    convenience init(isMultiselect: Bool) {
        self.init(frame: .zero)
        self.isMultiselect = isMultiselect
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
        collectionView.register(FilterSelectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    
    func resetData() {
        if isMultiselect {
            selectedData = [:]
            lastSelected = nil
        } else {
            selectedData = [0: true]
            lastSelected = 0
        }
        
        collectionView.reloadData()
    }
    
    func loadData(data: [String]) {
        self.data = data
        resetData()
    }
    
    func getData() -> [Int: Bool] {
        return selectedData
    }
}

extension FilterSelectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as! FilterSelectionCell
        

        
        cell.setup(name: data[indexPath.row], isSelected: selectedData[indexPath.row] ?? false)
            
        return cell
    }
}



extension FilterSelectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterSelectionCell {

            var currentlySelected = lastSelected
            if cell.clicked() {
                selectedData[indexPath.row] = true
                currentlySelected = indexPath.row
            } else {
                selectedData[indexPath.row] = false
            }


            if !isMultiselect {
                guard let lastSelectedCellIndex = lastSelected else {
                    lastSelected = currentlySelected
                    return
                }

                if lastSelectedCellIndex == indexPath.row {
                    lastSelected = nil
                    return
                }

                selectedData[lastSelectedCellIndex] = false
                lastSelected = indexPath.row
                if let lastSelectedCell = collectionView.cellForItem(at: IndexPath(row: lastSelectedCellIndex, section: 0)) as? FilterSelectionCell {
                    lastSelectedCell.clicked()
                    
                }
            }
        }
    }
}
