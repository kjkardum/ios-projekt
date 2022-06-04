//
//  FilterSliderView.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit


class FilterSliderView: UIView {
    let sliderView = UISlider()
    let valueLabel = UILabel()
    var items : [String] = ["", ""]
    var selectedElement : String?
    
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
        valueLabel.text = items[0]
        
        sliderView.minimumValue = 0
        sliderView.maximumValue = Float(upperLimit)
        sliderView.isContinuous = true
        sliderView.tintColor = .purple
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
            valueLabel.text = items[Int(sender.value)]
            
            selectedElement = items[Int(sender.value)]
            
            
        } else {
            valueLabel.text = String(sender.value)
            selectedElement = String(sender.value)
        }
        
    }
    
    
    func resetData() {
        selectedElement = items[0]
        UIView.animate(withDuration: 0.2) {
            self.sliderView.setValue(0, animated: true)
        }
        
        valueLabel.text = items[0]
    }
    
    
    func loadData(data: [String]) {
        self.items = data
        sliderView.maximumValue = Float(data.count - 1)
        resetData()
    }
    
    
}


