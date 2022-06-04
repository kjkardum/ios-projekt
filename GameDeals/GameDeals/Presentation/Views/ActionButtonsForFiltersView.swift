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
        addSubview(borderView)
        
        addSubview(clearFiltersButton)
        clearFiltersButton.setTitle("Clear All", for: .normal)
        clearFiltersButton.setTitleColor(.black, for: .normal)
        clearFiltersButton.backgroundColor = UIColor(red: 0.95, green: 0.94, blue: 0.95, alpha: 1.00)
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
        applyFiltersButton.backgroundColor = UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)
        applyFiltersButton.clipsToBounds = false
        applyFiltersButton.layer.cornerRadius = 25
        applyFiltersButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        applyFiltersButton.layer.shadowColor = UIColor.black.cgColor
        applyFiltersButton.layer.shadowOpacity = 0.15
        applyFiltersButton.layer.shadowRadius = 5
        applyFiltersButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        applyFiltersButton.addTarget(self, action: #selector(applyPressed), for: .touchUpInside)
        
        
        borderView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.00)
    }
    
    private func setLayout() {
        borderView.snp.makeConstraints {make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        clearFiltersButton.snp.makeConstraints {make in
            make.top.equalTo(borderView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.35)
            make.bottom.equalToSuperview()
        }
        
        applyFiltersButton.snp.makeConstraints {make in
            make.top.equalTo(borderView.snp.bottom).offset(20)
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
