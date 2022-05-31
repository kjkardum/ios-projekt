//
//  MovieCellToolbar.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import SnapKit
import UIKit

class DealCellToolbarView: UIView {
    let toolbarStackView = UIStackView()
    let priceStackView = UIStackView()
    let ratingStackView = UIStackView()
    
    let priceLabel = UILabel()
    let currentPriceLabel = UILabel()
    let priceBeforeSaleLabel = UILabel()
    
    let ratingLabel = UILabel()
    let ratingPercentageLabel = UILabel()
    
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
        
        addSubview(toolbarStackView)
        toolbarStackView.addArrangedSubview(priceStackView)
        toolbarStackView.addArrangedSubview(ratingStackView)
        
        toolbarStackView.axis = .horizontal
        toolbarStackView.distribution = .fillEqually
        toolbarStackView.alignment = .center
        
        priceStackView.axis = .vertical
        priceStackView.distribution = .fillEqually
        priceStackView.alignment = .center
        
        ratingStackView.axis = .vertical
        ratingStackView.distribution = .fillEqually
        ratingStackView.alignment = .center
        
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(currentPriceLabel)
        
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(ratingPercentageLabel)
        
        priceLabel.text = "Price:"
        priceLabel.textColor = .white
        
        ratingLabel.text = "Deal Rating:"
        ratingLabel.textColor = .white
        
        currentPriceLabel.textColor = .white
        
        ratingPercentageLabel.textColor = .white
    }
    
    
    private func setLayout() {
        toolbarStackView.snp.makeConstraints {make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    func loadToolbarData(currentPrice: String, priceBeforeSale: String, rating: String) {
        currentPriceLabel.text = "$"+currentPrice
        ratingPercentageLabel.text = rating
    }
}
