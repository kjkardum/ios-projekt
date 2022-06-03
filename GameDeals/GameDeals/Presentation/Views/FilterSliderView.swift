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
    let items : [String] = ["hahaha", "hehehe", "hihihi"]
    
    
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
        clipsToBounds = true
        layer.cornerRadius = 5
        
        addSubview(valueLabel)
        addSubview(sliderView)
        
        valueLabel.textColor = .white
        valueLabel.text = items[0]
        
        sliderView.minimumValue = 0
        sliderView.maximumValue = 1000000
        sliderView.isContinuous = true
        sliderView.tintColor = .purple
        sliderView.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        
        backgroundColor = .lightGray
    }
    
    private func setLayout() {
        valueLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        sliderView.snp.makeConstraints {make in
            make.top.equalTo(valueLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        let roundedStepValue = round(sender.value / Float(1000000/(items.count - 1))) * Float(1000000/(items.count - 1))

        sender.value = roundedStepValue
        valueLabel.text = items[Int((roundedStepValue/1000000)*Float(items.count-1))]
    }
}


