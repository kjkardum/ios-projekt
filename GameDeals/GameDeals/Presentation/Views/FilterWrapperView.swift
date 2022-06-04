//
//  FilterWrapperView.swift
//  GameDeals
//
//  Created by Five on 03.06.2022..
//

import Foundation
import UIKit



class FilterWrapperView<TKey>: UIView {
    private var selectionView: FilterSelectionView<TKey>?
    private var sliderView: FilterSliderView<TKey>?
    private var additionalSelectionView: UISegmentedControl?
    private let horizonalLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.86, alpha: 1.00)
        return view
    }()
    private let additionalHorizontalLineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.86, alpha: 1.00)
        return view
    }()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(title: String, sliderView: FilterSliderView<TKey>?) {
        self.init(frame: .zero)
        self.sliderView = sliderView
        titleLabel.text = title
        runFunctionsForBuildingSliderView()
    }
    
    convenience init(title: String, selectionView: FilterSelectionView<TKey>?) {
        self.init(frame: .zero)
        self.selectionView = selectionView
        titleLabel.text = title
        runFunctionsForBuildingSelectionView()
    }

    convenience init(title: String, selectionView: FilterSelectionView<TKey>?, additionalSelectionView: UISegmentedControl?) {
        self.init(frame: .zero)
        self.additionalSelectionView = additionalSelectionView
        self.selectionView = selectionView
        titleLabel.text = title
        runFunctionsForBuildingSelectionView()
    }
    
    convenience init(title: String, sliderView: FilterSliderView<TKey>?, additionalSelectionView: UISegmentedControl?) {
        self.init(frame: .zero)
        self.additionalSelectionView = additionalSelectionView
        self.sliderView = sliderView
        titleLabel.text = title
        runFunctionsForBuildingSliderView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func runFunctionsForBuildingSelectionView() {
        buildMainView()
        setLayoutForMainView()
        buildSelectionView()
        setLayoutForSelectionView()
    }
    
    private func runFunctionsForBuildingSliderView() {
        buildMainView()
        setLayoutForMainView()
        buildSliderView()
        setLayoutForSliderView()
    }
    
    private func buildMainView() {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = UIColor(red: 0.95, green: 0.94, blue: 0.95, alpha: 1.00)
        
        addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = .black
        
        additionalSelectionView?.selectedSegmentIndex = 0
        additionalSelectionView?.selectedSegmentTintColor = .white
        additionalSelectionView?.tintColor = UIColor(red: 0.89, green: 0.88, blue: 0.89, alpha: 1.00)
        
        addSubview(horizonalLineView)
    }
    
    private func setLayoutForMainView() {
        titleLabel.snp.makeConstraints {make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(15)
        }
        
        horizonalLineView.snp.makeConstraints {make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func buildSliderView() {
        guard let sliderView = self.sliderView else {
            return
        }
        
        addSubview(sliderView)
        
        
        guard let additionalSelectionView = self.additionalSelectionView else {
            return
        }
        
        addSubview(additionalHorizontalLineView)
        addSubview(additionalSelectionView)
    }
    
    private func setLayoutForSliderView() {
        guard let sliderView = self.sliderView else {
            return
        }
        
        guard let additionalSelectionView = self.additionalSelectionView else {
            sliderView.snp.makeConstraints {make in
                make.top.equalTo(horizonalLineView.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().inset(15)
                make.height.equalTo(80)
                make.bottom.equalToSuperview().inset(15)
            }
            return
        }
        
        sliderView.snp.makeConstraints {make in
            make.top.equalTo(horizonalLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(80)
        }
        
        additionalHorizontalLineView.snp.makeConstraints {make in
            make.top.equalTo(sliderView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        additionalSelectionView.snp.makeConstraints {make in
            make.top.equalTo(additionalHorizontalLineView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    
    
    private func buildSelectionView() {
        guard let selectionView = self.selectionView else {
            return
        }
        
        addSubview(selectionView)
        
        
        guard let additionalSelectionView = self.additionalSelectionView else {
            return
        }
        
        addSubview(additionalHorizontalLineView)
        addSubview(additionalSelectionView)
    }
    
    private func setLayoutForSelectionView() {
        guard let selectionView = self.selectionView else {
            return
        }
        
        guard let additionalSelectionView = self.additionalSelectionView else {
            selectionView.snp.makeConstraints {make in
                make.top.equalTo(horizonalLineView.snp.bottom).offset(5)
                make.trailing.leading.equalToSuperview().inset(15)
                make.height.equalTo(50)
                make.bottom.equalToSuperview().inset(5)
            }
            return
        }
        
        selectionView.snp.makeConstraints {make in
            make.top.equalTo(horizonalLineView.snp.bottom).offset(5)
            make.trailing.leading.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        additionalHorizontalLineView.snp.makeConstraints {make in
            make.top.equalTo(selectionView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        additionalSelectionView.snp.makeConstraints {make in
            make.top.equalTo(additionalHorizontalLineView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func loadSelectionViewWithData(data: [StringWithKey<TKey>]) {
        if let selectionView = self.selectionView {
            selectionView.loadData(data: data)
        }
    }
    
    func loadSliderViewWithData(data: [StringWithKey<TKey>]) {
        if let sliderView = self.sliderView {
            sliderView.loadData(data: data)
        }
    }
    
    func getSelectionViewData() -> [StringWithKey<TKey>] {
        if let selectionView = self.selectionView {
            return selectionView.getData()
        }
        
        return []
    }
    
    func getSliderViewData() -> StringWithKey<TKey>? {
        if let sliderView = self.sliderView {
            return sliderView.getData()
        }
        
        return nil
    }
    
    func getSliderViewValue() -> Int? {
        if let sliderView = self.sliderView {
            return sliderView.getSliderValue()
        }
        
        return nil
    }
    
    func getAdditionalSelectionViewValue() -> Bool? {
        if let additionalSelectionView = self.additionalSelectionView {
            switch(additionalSelectionView.selectedSegmentIndex) {
            case 0:
                return false
            case 1:
                return true
            default:
                return false
            }
        }
        
        return nil
    }
    
    func resetData() {
        selectionView?.resetData()
        sliderView?.resetData()
        additionalSelectionView?.selectedSegmentIndex = 0
    }
}
