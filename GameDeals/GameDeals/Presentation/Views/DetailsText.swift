

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
    
    let ratingStackView = CustomDetailsStackView()
    
    let priceStackView = CustomDetailsStackView()
    
    let priceSaleStackView = CustomDetailsStackView()
    
    let releaseDateStackView = CustomDetailsStackView()
    
    
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
        backgroundColor = .gray
        
        addSubview(mainStack)
        mainStack.addArrangedSubview(upStack)
        mainStack.addArrangedSubview(downStack)
        
        mainStack.axis = .vertical
        mainStack.distribution = .fillEqually
        mainStack.alignment = .center
        
        upStack.axis = .horizontal
        upStack.distribution = .fillEqually
        upStack.alignment = .center
        
        downStack.axis = .vertical
        downStack.distribution = .fillEqually
        downStack.alignment = .center
        
        upStack.addArrangedSubview(priceStackView)
        priceStackView.nameLabel.text = "price"
        upStack.addArrangedSubview(priceSaleStackView)
        priceSaleStackView.nameLabel.text = "sale price"
        downStack.addArrangedSubview(ratingStackView)
        ratingStackView.nameLabel.text = "rating"
        downStack.addArrangedSubview(releaseDateStackView)
        releaseDateStackView.nameLabel.text = "release date"
        
    }
    
    private func setLayout() {
        mainStack.snp.makeConstraints {make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    func loadDetailsData(currentPrice: String, priceBeforeSale: String, rating: String,
                         releaseDate: String) {
        
        priceStackView.valueLabel.text = priceBeforeSale + "$"
        priceSaleStackView.valueLabel.text = currentPrice + "$"
        releaseDateStackView.valueLabel.text = releaseDate
        ratingStackView.valueLabel.text = rating
    }
}
