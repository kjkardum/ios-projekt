//
//  RatingStackView.swift
//  GameDeals
//
//  Created by Five on 08.06.2022..
//

import Foundation
import UIKit
import SnapKit
import SFSafeSymbols


class RatingStackView: UIView {
    private let stackView = UIStackView()
    private var starSize: Int = 10
    private let star0 = UIButton()
    private let star1 = UIButton()
    private let star2 = UIButton()
    private let star3 = UIButton()
    private let star4 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    convenience init(starSize: Int) {
        self.init(frame: .zero)
        self.starSize = starSize

        star0.setImage(.star, for: .normal)
        star0.tintColor = .starColor
        star0.isUserInteractionEnabled = false
        
        star1.setImage(.star, for: .normal)
        star1.tintColor = .starColor
        star1.isUserInteractionEnabled = false
        
        star2.setImage(.star, for: .normal)
        star2.tintColor = .starColor
        star2.isUserInteractionEnabled = false
        
        star3.setImage(.star, for: .normal)
        star3.tintColor = .starColor
        star3.isUserInteractionEnabled = false
    
        star4.setImage(.star, for: .normal)
        star4.tintColor = .starColor
        star4.isUserInteractionEnabled = false
        
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        addSubview(stackView)
        
        stackView.axis = .horizontal
        

        stackView.addArrangedSubview(star0)
    
    
        stackView.addArrangedSubview(star1)
    
    
        stackView.addArrangedSubview(star2)
    
    
        stackView.addArrangedSubview(star3)
    
    
        stackView.addArrangedSubview(star4)
        
    }
    
    private func setLayout() {
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func editStars(rating: Double) {
        if rating >= 0.5 {
            star0.setImage(.starLeadinghalfFilled, for: .normal)
        }
        
        if rating >= 1 {
            star0.setImage(.starFill, for: .normal)
        }
        
        if rating >= 1.5 {
            star1.setImage(.starLeadinghalfFilled, for: .normal)
        }
        
        if rating >= 2 {
            star1.setImage(.starFill, for: .normal)
        }
        
        if rating >= 2.5 {
            star2.setImage(.starLeadinghalfFilled, for: .normal)
        }
        
        if rating >= 3 {
            star2.setImage(.starFill, for: .normal)
        }
        
        if rating >= 3.5 {
            star3.setImage(.starLeadinghalfFilled, for: .normal)
        }
        
        if rating >= 4 {
            star3.setImage(.starFill, for: .normal)
        }
        
        if rating >= 4.3 {
            star4.setImage(.starLeadinghalfFilled, for: .normal)
        }
        
        if rating >= 4.7 {
            star4.setImage(.starFill, for: .normal)
        }
    }
    
    func resetStars() {
        star0.setImage(.star, for: .normal)
        
        star1.setImage(.star, for: .normal)

        star2.setImage(.star, for: .normal)

        star3.setImage(.star, for: .normal)
        
        star4.setImage(.star, for: .normal)
    }
}
