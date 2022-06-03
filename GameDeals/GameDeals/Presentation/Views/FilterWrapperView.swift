//
//  FilterWrapperView.swift
//  GameDeals
//
//  Created by Five on 03.06.2022..
//

import Foundation
import UIKit



class FilterWrapperView: UIView {
    private var selectionView: FilterSelectionView?
    private var sliderView: FilterSliderView?
    private var additionalSelectionView: FilterSelectionView?
    private let horizonalLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(title: String, sliderView: FilterSliderView?) {
        self.init(frame: .zero)
        self.sliderView = sliderView
        titleLabel.text = title
        buildMainView()
        setLayoutForMainView()
        buildSliderView()
        setLayoutForSliderView()
    }
    
    convenience init(title: String, selectionView: FilterSelectionView?) {
        self.init(frame: .zero)
        self.selectionView = selectionView
        titleLabel.text = title
        buildMainView()
        setLayoutForMainView()
        buildSelectionView()
        setLayoutForSelectionView()
    }

    convenience init(title: String, selectionView: FilterSelectionView?, additionalSelectionView: FilterSelectionView?) {
        self.init(frame: .zero)
        self.selectionView = selectionView
        self.additionalSelectionView = additionalSelectionView
        titleLabel.text = title
        buildMainView()
        setLayoutForMainView()
    }
    
    convenience init(title: String, sliderView: FilterSliderView?, additionalSelectionView: FilterSelectionView?) {
        self.init(frame: .zero)
        self.sliderView = sliderView
        self.additionalSelectionView = additionalSelectionView
        titleLabel.text = title
        buildMainView()
        setLayoutForMainView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func buildMainView() {
        clipsToBounds = true
        layer.cornerRadius = 5
        backgroundColor = .lightGray
        
        addSubview(titleLabel)
        
        addSubview(horizonalLineView)
    }
    
    private func setLayoutForMainView() {
        titleLabel.snp.makeConstraints {make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        horizonalLineView.snp.makeConstraints {make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
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
        
        addSubview(additionalSelectionView)
    }
    
    private func setLayoutForSliderView() {
        guard let sliderView = self.sliderView else {
            return
        }
        
        sliderView.snp.makeConstraints {make in
            make.top.equalTo(horizonalLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func setLayoutForSliderViewWithAddition() {
        guard let sliderView = self.sliderView else {
            return
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
        
        addSubview(additionalSelectionView)
    }
    
    private func setLayoutForSelectionView() {
        guard let selectionView = self.selectionView else {
            return
        }
        
        selectionView.snp.makeConstraints {make in
            make.top.equalTo(horizonalLineView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }
        
    }
    
    private func setLayoutForSelectionViewWithAddition() {
        
    }
}
