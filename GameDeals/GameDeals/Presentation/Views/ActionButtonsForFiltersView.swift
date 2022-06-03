//
//  ActionButtonsForFiltersView.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit

class ActionButtonsForFiltersView: UIView {
    private let clearFiltersButton = UIButton()
    private let applyFiltersButton = UIButton()
    private let borderView = UIView()
    
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
        addSubview(borderView)
        
        addSubview(clearFiltersButton)
        clearFiltersButton.setTitle("Clear All", for: .normal)
        clearFiltersButton.setTitleColor(.black, for: .normal)
        clearFiltersButton.backgroundColor = .lightGray
        clearFiltersButton.clipsToBounds = true
        clearFiltersButton.layer.cornerRadius = 25
        
        
        addSubview(applyFiltersButton)
        applyFiltersButton.setTitle("Apply Filters", for: .normal)
        applyFiltersButton.setTitleColor(.white, for: .normal)
        applyFiltersButton.backgroundColor = .purple
        applyFiltersButton.clipsToBounds = true
        applyFiltersButton.layer.cornerRadius = 25
        
        borderView.backgroundColor = .lightGray
    }
    
    private func setLayout() {
        borderView.snp.makeConstraints {make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        clearFiltersButton.snp.makeConstraints {make in
            make.top.equalTo(borderView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.bottom.equalToSuperview()
        }
        
        applyFiltersButton.snp.makeConstraints {make in
            make.top.equalTo(borderView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
    }
}
