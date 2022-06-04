//
//  FilterSelectionCell.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit



class FilterSelectionCell: UICollectionViewCell {
    let button = UILabel()
    var clickStatus = false

    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }

    
    private func buildViews() {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = .clear
        
        addSubview(button)
        button.font = UIFont.systemFont(ofSize: 15)
        button.textColor = .black
        button.textAlignment = .center
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    private func setLayout() {
        button.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    
    private func addBorder() {
        backgroundColor = UIColor(red: 0.83, green: 0.83, blue: 0.83, alpha: 1.00)
        button.invalidateIntrinsicContentSize()
        
    }
    
    private func removeBorder() {
        backgroundColor = .clear
        button.font = UIFont.systemFont(ofSize: 15)
        
    
    }
    
    private func handleClick(isSelected: Bool) {
        switch(isSelected) {
        case true:
            clickStatus = true
            UIView.animate(withDuration: 0.2) {
                self.addBorder()
            }
            return
        case false:
            clickStatus = false
            UIView.animate(withDuration: 0.2) {
                self.removeBorder()
            }
            return
        }
    }
    
    
    func setup(name: String, isSelected: Bool) {
        button.text = name
        handleClick(isSelected: isSelected)
    }
    
    func clicked() -> Bool {
        switch(clickStatus) {
        case false:
            handleClick(isSelected: !clickStatus)
            return true
        case true:
            handleClick(isSelected: !clickStatus)
            return false
        }
    }
}