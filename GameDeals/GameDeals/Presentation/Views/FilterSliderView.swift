//
//  FilterSliderView.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit


class FilterSliderView<TKey>: UIView {
    let sliderView = UISlider()
    let valueLabel = UILabel()
    var items : [StringWithKey<TKey>] = []
    var selectedElement : StringWithKey<TKey>?
    var selectedValue : Int?
    
    var fullyContinuous = false
    var upperLimit = 1000
    
    var animationInProgress = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    convenience init() {
        self.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    convenience init(fullyContinuous: Bool, upperLimit: Int) {
        self.init(frame: .zero)
        self.fullyContinuous = fullyContinuous
        self.upperLimit = upperLimit
        buildViews()
        setLayout()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func buildViews() {
        clipsToBounds = true
        layer.cornerRadius = 5
        
        addSubview(valueLabel)
        addSubview(sliderView)
        
        valueLabel.textColor = UIColor(red: 0.57, green: 0.56, blue: 0.57, alpha: 1.00)
        valueLabel.text = "Any rating"
        
        sliderView.minimumValue = 0
        sliderView.maximumValue = Float(upperLimit)
        sliderView.value = 0
        sliderView.isContinuous = true
        sliderView.tintColor = UIColor(red: 0.24, green: 0.30, blue: 0.72, alpha: 1.00)
        sliderView.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        
        backgroundColor = .clear
    }
    
    private func setLayout() {
        valueLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        
        sliderView.snp.makeConstraints {make in
            make.top.equalTo(valueLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        if !fullyContinuous {
            valueLabel.text = items[Int(sender.value)].name
            
            selectedElement = items[Int(sender.value)]
            
            
        } else {
            let roundedValue = (sender.value * 100).rounded() / 100
            if roundedValue == 0 {
                valueLabel.text = "Any rating"
            } else {
                valueLabel.text = "Rating greater than " + String(Int(roundedValue))
            }
            
            selectedValue = Int(roundedValue)
        }
    }
    
    
    func resetData() {
        if fullyContinuous {
            valueLabel.text = "Any rating"
            selectedValue = nil
        } else {
            selectedElement = items[0]
            valueLabel.text = items[0].name
        }
        
        UIView.animate(withDuration: 0.2) {
            self.sliderView.setValue(0, animated: true)
        }
    }
    
    
    func loadData(data: [StringWithKey<TKey>]) {
        self.items = data
        sliderView.maximumValue = Float(data.count - 1)
        resetData()
    }
    
    
    func getData() -> StringWithKey<TKey>? {
        return selectedElement
    }
    
    func getSliderValue() -> Int? {
        if selectedValue == 0 {
            return nil
        }
        return selectedValue
    }
    
}


