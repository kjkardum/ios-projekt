

//
//  DetailsText.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit

class DetailsText: UIView {
    let mainStack = UIStackView()
    let upStack = UIStackView()
    let downStack = UIStackView()
    
    let ratingStackView = CustomDetailsStackView(isText: false)
    
    let priceStackView = CustomDetailsStackView(isText: true)
    
    let priceSaleStackView = CustomDetailsStackView(isText: true)
    
    let secondRatingStackView = CustomDetailsStackView(isText: false)
    
    
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
        backgroundColor = UIColor(red: 0.43, green: 0.47, blue: 0.96, alpha: 0.3)
        clipsToBounds = true
        layer.cornerRadius = 20
        
        addSubview(mainStack)
        mainStack.addArrangedSubview(upStack)
        mainStack.addArrangedSubview(downStack)
        
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.alignment = .center
        
        upStack.axis = .horizontal
        upStack.distribution = .fillEqually
        upStack.alignment = .center
        
        downStack.axis = .horizontal
        downStack.distribution = .fillEqually
        downStack.alignment = .center
        
        upStack.addArrangedSubview(priceSaleStackView)
        priceSaleStackView.editTextLabel("Sale Price")
        
        upStack.addArrangedSubview(priceStackView)
        priceStackView.editTextLabel("Price Before Sale")
        
        downStack.addArrangedSubview(ratingStackView)
        ratingStackView.editTextLabel("Steam Rating")
        
        downStack.addArrangedSubview(secondRatingStackView)
        secondRatingStackView.editTextLabel("Metacritic Rating")
        
    }
    
    private func setLayout() {
        mainStack.snp.makeConstraints {make in
            make.top.width.bottom.equalToSuperview()
        }
        
        upStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        downStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    private func createValueLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }
    
    
    func loadDetailsData(currentPrice: String, priceBeforeSale: String, rating: Int,
                         metacritic: Int) {

        priceStackView.editValueLabel(priceBeforeSale + "$")
        priceSaleStackView.editValueLabel(currentPrice + "$")
        
        ratingStackView.editStarRating(Double(rating)/20)
        secondRatingStackView.editStarRating(Double(metacritic)/20)

    }
}
