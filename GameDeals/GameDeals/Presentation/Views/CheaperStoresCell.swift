//
//  CheaperStoresCell.swift
//  GameDeals
//
//  Created by Five on 08.06.2022..
//

import Foundation
import UIKit
import SnapKit


class CheaperStoresCell: UICollectionViewCell {
    let storeCellView = UIView()
    let img = UIImageView()
    let shopTitleLabel = UILabel()
    let retailPriceLabel = UILabel()
    let salePriceLabel = UILabel()
    let titleStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        backgroundColor = .clear
        addSubview(storeCellView)
        
        storeCellView.addSubview(img)
        storeCellView.addSubview(shopTitleLabel)
        storeCellView.addSubview(salePriceLabel)
        storeCellView.addSubview(retailPriceLabel)

//        storeCellView.addSubview(titleStackView)
//
//
//        titleStackView.addArrangedSubview(shopTitleLabel)
//        titleStackView.addArrangedSubview(retailPriceLabel)
//        titleStackView.addArrangedSubview(UIView())
//        titleStackView.axis = .vertical
//        titleStackView.distribution = .fill
//        titleStackView.alignment = .leading
//        titleStackView.spacing = 5
        
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.searchAccentColor.cgColor
        
        shopTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        shopTitleLabel.textColor = .white
        shopTitleLabel.numberOfLines = 1
        
        salePriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        salePriceLabel.textColor = .white
        salePriceLabel.lineBreakMode = .byWordWrapping
        salePriceLabel.numberOfLines = 1
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Your String here")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        retailPriceLabel.font = UIFont.systemFont(ofSize: 15)
        retailPriceLabel.attributedText = attributeString
        retailPriceLabel.textColor = .searchAccentColor
        retailPriceLabel.lineBreakMode = .byWordWrapping
        retailPriceLabel.numberOfLines = 1

        
        storeCellView.clipsToBounds = true
        storeCellView.layer.cornerRadius = 15
        storeCellView.backgroundColor = .recommendedBackgroundColor
        
        backgroundColor = .clear
    }
    
    private func setLayout() {
        storeCellView.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        img.snp.makeConstraints {make in
            make.top.leading.bottom.equalToSuperview().inset(15)
            make.width.equalTo(40)
        }
        
        shopTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(img.snp.trailing).offset(10)
        }
        
        retailPriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(2)
            make.trailing.equalToSuperview().inset(10)
        }
        
        salePriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(retailPriceLabel.snp.leading).offset(-3)
        }
//        titleStackView.snp.makeConstraints { make in
//            make.leading.equalTo(img.snp.trailing).offset(15)
//            make.trailing.bottom.top.equalToSuperview().inset(15)
//
//        }

    }
    
    
    func setup(cheaperStoreData: DealCheaperStore, shop: Shop?) {
        if let shop = shop {
            if let thumb = shop.images.logo {
                self.img.image = UIImage(data: thumb)
            }
            
            self.shopTitleLabel.text = shop.storeName
        }
        
        self.salePriceLabel.text = cheaperStoreData.salePrice + "$"
        self.retailPriceLabel.text = cheaperStoreData.retailPrice + "$"
    }
}
