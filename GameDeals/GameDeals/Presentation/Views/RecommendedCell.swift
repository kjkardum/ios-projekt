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
    let likeButton = UIButton()
    var likeState = false
    weak var likeDealDelegate: LikeDealDelegate?
    var dealId: String?
    
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
        
        recommendedCellView.addSubview(likeButton)
        
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
        img.layer.borderColor = UIColor.searchAccentColor.cgColor
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.textColor = .searchAccentColor
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        
        
        likeButton.setImage(.heart, for: .normal)
        likeButton.tintColor = .searchAccentColor
        likeButton.addTarget(self, action: #selector(likeClicked), for: .touchUpInside)

        
        recommendedCellView.clipsToBounds = true
        recommendedCellView.layer.cornerRadius = 15
        recommendedCellView.backgroundColor = .recommendedBackgroundColor
        
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
            make.trailing.equalTo(likeButton.snp.leading).offset(-10)
            
        }
        likeButton.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(super.snp.trailing).offset(-60)
            
        }
    }
    
    @objc func likeClicked() {
        likeState = !likeState
        if let dealId = dealId {
            likeDealDelegate?.likeDeal(dealId: dealId, like: likeState)
        }
        if likeState {
            likeButton.setImage(.heartFill, for: .normal)
            likeButton.tintColor = .heartColor
        } else {
            likeButton.setImage(.heart, for: .normal)
            likeButton.tintColor = .searchAccentColor
        }
    }
    
    
    func setup(dealData: Deal) {
        dealId = dealData.dealID
        
        if let thumb = dealData.thumb {
            self.img.image = UIImage(data: thumb)
        }
        
        self.titleLabel.text = dealData.title
        self.priceLabel.text = dealData.salePrice + "$"
        
        likeState = dealData.liked
        
        if likeState {
            likeButton.setImage(.heartFill, for: .normal)
            likeButton.tintColor = .heartColor
        } else {
            likeButton.setImage(.heart, for: .normal)
            likeButton.tintColor = .searchAccentColor
        }
        
    }
    
}
