//
//  FilterSelectionCell.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit


enum SelectionCellStyle {
    case standard
    case radio
}


class FilterSelectionCell: UICollectionViewCell {
    let testView = UIView()
    let buttonBorder : UIView = {
        let border = UIView()
        border.backgroundColor = .black
        return border
    }()
    
    let button = UILabel()
    var clickStatus = false
    
    var cellStyle: SelectionCellStyle = .standard
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        
    }

    
    
    private func buildViews() {
        clipsToBounds = true
        layer.cornerRadius = 5
        backgroundColor = .clear
        
        addSubview(button)
        button.font = UIFont.systemFont(ofSize: 22)
        button.textColor = .black
        button.textAlignment = .center
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    private func setStandardLayout() {
        button.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setRadioLayout() {
        button.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func addBorder() {
        switch (cellStyle) {
        case .standard:
            button.addSubview(buttonBorder)
            button.font = UIFont.boldSystemFont(ofSize: 21)
            buttonBorder.snp.makeConstraints{ (make) in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(button.snp.bottom).offset(3)
                make.height.equalTo(3)
            }
            button.invalidateIntrinsicContentSize()
            clickStatus = true
            return
            
        case .radio:
            button.textColor = .purple
            self.layer.borderColor = UIColor.purple.cgColor
            clickStatus = true
            return
        }
        
    }
    
    private func removeBorder() {
        switch (cellStyle) {
        case .standard:
            buttonBorder.removeFromSuperview()
            button.font = UIFont.systemFont(ofSize: 22)
            clickStatus = false
            return
            
        case .radio:
            button.textColor = .black
            self.layer.borderColor = UIColor.lightGray.cgColor
            clickStatus = false
            return
        }
        
    }
    
    func setup(name: String, cellStyle: SelectionCellStyle) {
        self.cellStyle = cellStyle
        button.text = name+" " // Jako cringe ali funkcionira i nemam vise vremena radit na tome
        
        switch(cellStyle) {
        case .standard:
            setStandardLayout()
            return
        case .radio:
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.lightGray.cgColor
            setRadioLayout()
            return
        }
    }
    
    func clicked() -> Bool {
        switch(clickStatus) {
        case false:
            addBorder()

            return true
        case true:
            removeBorder()

            return false
        }
    }
}
