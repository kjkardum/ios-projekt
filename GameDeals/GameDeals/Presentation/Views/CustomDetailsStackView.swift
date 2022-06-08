//
//  CustomDetailsStackView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit
import SFSafeSymbols
class CustomDetailsStackView: UIView{
    private let mainStackView = UIStackView()
    private let nameLabel = UILabel()
    private let valueLabel = UILabel()
    private let starRating = RatingStackView(starSize: 10)
    private var isText: Bool = true
    
    convenience init(isText: Bool) {
        self.init(frame: .zero)
        self.isText = isText
        buildViews()
        setLayout()
    }
    
    private func buildViews() {
        addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.spacing = 7
        mainStackView.addArrangedSubview(nameLabel)
        
        if isText {
            mainStackView.addArrangedSubview(valueLabel)
        } else {
            mainStackView.addArrangedSubview(starRating)
        }
        
        valueLabel.font = UIFont.boldSystemFont(ofSize: 18)
        valueLabel.textColor = .white
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
    }
    private func setLayout(){
        mainStackView.snp.makeConstraints {make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func editStarRating(_ rating: Double) {
        starRating.editStars(rating: rating)
    }
    
    func editValueLabel(_ text: String) {
        valueLabel.text = text
    }
    
    func editTextLabel(_ text: String) {
        nameLabel.text = text
    }
}
