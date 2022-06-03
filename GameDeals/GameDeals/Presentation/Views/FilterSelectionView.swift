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
    private var data : [String] = ["haha", "hehe", "hihi", "hoho", "huhu", "1bnh", "2", "3", "4", "sfdkjhsdfjhsjhf"]
    
    private var selectedData: [Int: Bool] = [:]
    
    private var lastSelected : Int?
    
    private var isMultiselect = false
    
    private var cellStyle : SelectionCellStyle = .standard
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    convenience init(isMultiselect: Bool, cellStyle: SelectionCellStyle) {
        self.init(frame: .zero)
        self.isMultiselect = isMultiselect
        self.cellStyle = cellStyle
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

        
        
        cell.setup(name: data[indexPath.row], cellStyle: cellStyle)
            
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
                
                
                if let lastSelectedCell = collectionView.cellForItem(at: IndexPath(row: lastSelectedCellIndex, section: 0)) as? FilterSelectionCell {
                    lastSelectedCell.clicked()
                    selectedData[lastSelectedCellIndex] = false
                    lastSelected = indexPath.row
                }
            }
        }
    }
}
