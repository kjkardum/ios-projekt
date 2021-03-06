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
    
    weak var actionButtonsDelegate : FilterActionButtonsDelegate?
    
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
        
        addSubview(clearFiltersButton)
        clearFiltersButton.setTitle("Clear All", for: .normal)
        clearFiltersButton.setTitleColor(.black, for: .normal)
        clearFiltersButton.backgroundColor = UIColor.clearFiltersButtonColor
        clearFiltersButton.clipsToBounds = false
        clearFiltersButton.layer.cornerRadius = 25
        clearFiltersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        clearFiltersButton.layer.shadowColor = UIColor.black.cgColor
        clearFiltersButton.layer.shadowOpacity = 0.15
        clearFiltersButton.layer.shadowRadius = 5
        clearFiltersButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        clearFiltersButton.addTarget(self, action: #selector(clearPressed), for: .touchUpInside)
        
        
        addSubview(applyFiltersButton)
        applyFiltersButton.setTitle("Apply Filters", for: .normal)
        applyFiltersButton.setTitleColor(.white, for: .normal)
        applyFiltersButton.backgroundColor = UIColor.filterViewAccent
        applyFiltersButton.clipsToBounds = false
        applyFiltersButton.layer.cornerRadius = 25
        applyFiltersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        applyFiltersButton.layer.shadowColor = UIColor.black.cgColor
        applyFiltersButton.layer.shadowOpacity = 0.15
        applyFiltersButton.layer.shadowRadius = 5
        applyFiltersButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        applyFiltersButton.addTarget(self, action: #selector(applyPressed), for: .touchUpInside)
        
    }
    
    private func setLayout() {
        clearFiltersButton.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.bottom.equalToSuperview()
        }
        
        applyFiltersButton.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func clearPressed() {
        actionButtonsDelegate?.clearButtonPressed()
    }
    
    @objc private func applyPressed() {
        actionButtonsDelegate?.applyButtonPressed()
    }
}
