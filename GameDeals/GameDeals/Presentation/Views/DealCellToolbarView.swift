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
    let ratingPercentage = RatingStackView(starSize: 10)
    
    let saleAndRetailPriceStackView = UIStackView()
    
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
        priceStackView.addArrangedSubview(saleAndRetailPriceStackView)
        
        saleAndRetailPriceStackView.addArrangedSubview(currentPriceLabel)
        saleAndRetailPriceStackView.addArrangedSubview(priceBeforeSaleLabel)
        
        saleAndRetailPriceStackView.axis = .horizontal
        saleAndRetailPriceStackView.spacing = 2
        
        ratingStackView.addArrangedSubview(ratingLabel)
        ratingStackView.addArrangedSubview(ratingPercentage)
        
        priceLabel.text = "Price"
        priceLabel.textColor = .subtextColorToolbar
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        ratingLabel.text = "Steam Rating"
        ratingLabel.textColor = .subtextColorToolbar
        ratingLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        currentPriceLabel.textColor = .white
        currentPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        priceBeforeSaleLabel.textColor = .searchAccentColor
        priceBeforeSaleLabel.font = UIFont.systemFont(ofSize: 14)

        
    }
    
    
    private func setLayout() {
        toolbarStackView.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
    
    func loadToolbarData(currentPrice: String, priceBeforeSale: String, steamRating: Int?, metaCriticRating: Int, dealRating: String) {
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$"+priceBeforeSale)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        priceBeforeSaleLabel.attributedText = attributeString
        
        currentPriceLabel.text = "$"+currentPrice
        
        ratingLabel.text = "Deal Rating"
        if Double(dealRating) == 0 {
            ratingPercentage.resetStars()
            ratingPercentage.editStars(rating: 0)
        } else {
            ratingPercentage.resetStars()
            if let dealRating = Double(dealRating) {
                ratingPercentage.editStars(rating: dealRating/2)
            }
            
        }
        
        
        if metaCriticRating != 0 {
            ratingLabel.text = "Metacritic Rating"
            ratingPercentage.resetStars()
            ratingPercentage.editStars(rating: Double(metaCriticRating)/20)
        }
        
        if let steamRating = steamRating{
            if steamRating != 0 {
                ratingLabel.text = "Steam Rating"
                ratingPercentage.resetStars()
                ratingPercentage.editStars(rating: Double(steamRating)/20)
            }
        }
    }
}
