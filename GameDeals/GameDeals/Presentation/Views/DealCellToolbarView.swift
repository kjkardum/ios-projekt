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
        backgroundColor = UIColor.backgroundColorAccent
        
        addSubview(toolbarStackView)
        toolbarStackView.addArrangedSubview(priceStackView)
        toolbarStackView.addArrangedSubview(ratingStackView)
        
        toolbarStackView.axis = .horizontal
        toolbarStackView.distribution = .fillEqually
        toolbarStackView.alignment = .center
        
        priceStackView.axis = .vertical
        priceStackView.distribution = .fillEqually
        priceStackView.alignment = .center
        priceStackView.spacing = 5
        
        ratingStackView.axis = .vertical
        ratingStackView.distribution = .fillEqually
        ratingStackView.alignment = .center
        ratingStackView.spacing = 5
        
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(currentPriceLabel)
        
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(ratingPercentageLabel)
        
        priceLabel.text = "Price"
        priceLabel.textColor = UIColor.subtextColor
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        ratingLabel.text = "Steam Rating"
        ratingLabel.textColor = UIColor.subtextColor
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        currentPriceLabel.textColor = .white
        currentPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        ratingPercentageLabel.textColor = .white
        ratingPercentageLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    
    private func setLayout() {
        toolbarStackView.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    
    func loadToolbarData(currentPrice: String, priceBeforeSale: String, steamRating: Int?, metaCriticRating: Int?, dealRating: String?) {
        currentPriceLabel.text = "$"+currentPrice
        if let steamRating = steamRating {
            ratingPercentageLabel.text = String(steamRating)
        } else {
            if let metaCriticRating = metaCriticRating {
                ratingLabel.text = "Metacritic Rating"
                ratingPercentageLabel.text = String(metaCriticRating)
            } else {
                ratingLabel.text = "Deal Rating"
                ratingPercentageLabel.text = dealRating
            }
        }
        
    }
}
