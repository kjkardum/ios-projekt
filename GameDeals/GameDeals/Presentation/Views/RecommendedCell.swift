//
//  RecommendedView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//

import Foundation
import UIKit
import SnapKit

    
class RecommendedCell: UICollectionViewCell {
    let recommendedCellView = UIView()
    let img = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let titleStackView = UIStackView()
    let button = UIButton()
    
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
        addSubview(recommendedCellView)
        
        recommendedCellView.addSubview(img)

        recommendedCellView.addSubview(titleStackView)
        
        recommendedCellView.addSubview(button)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(priceLabel)
        titleStackView.addArrangedSubview(UIView())
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.alignment = .leading
        titleStackView.spacing = 5
        
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).cgColor
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        
//        button.setTitle( "like", for: .normal)
        button.setImage(.heart, for: .normal)
        button.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)

        
        
        recommendedCellView.clipsToBounds = true
        recommendedCellView.layer.cornerRadius = 15
//        recommendedCellView.layer.borderColor = UIColor.filterViewBorder.cgColor
        recommendedCellView.backgroundColor = .recommendedBackgroundColor
//        recommendedCellView.layer.borderWidth = 2
        
        backgroundColor = .clear
    }
    
    private func setLayout() {
        recommendedCellView.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        img.snp.makeConstraints {make in
            make.top.leading.bottom.equalToSuperview().inset(15)
            make.width.equalTo(87)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(15)
            make.bottom.top.equalToSuperview().inset(15)
            make.trailing.equalTo(button.snp.leading).offset(-10)
            
        }
        button.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(super.snp.trailing).offset(-60)
            
        }
        
        
        

    }
    
    
    private func setImageConstraint() {
        if img.image == nil {
            return
        }
        
        let myImageWidth = img.image!.size.width
        let myImageHeight = img.image!.size.height
        let myViewWidth = recommendedCellView.frame.size.width

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        
//        img.snp.updateConstraints { (make) in
//            make.height.equalTo(scaledHeight)
//        }
    }
    
    
    func setup(dealData: Deal) {
        
        if let thumb = dealData.thumb {
            self.img.image = UIImage(data: thumb)
//            self.setImageConstraint()
        }
        
        self.titleLabel.text = dealData.title
        self.priceLabel.text = dealData.salePrice + "$"
        
    }
    
}



