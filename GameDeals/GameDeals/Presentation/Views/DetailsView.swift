//
//  DetailsView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit

class DetailsView: UIView {
    private let scrollView = UIScrollView()
    private let titleReleaseDateStackView = UIStackView()
    private let detailsText = UIView()
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let text = DetailsText()
    private let cheaperStoresLabel = UILabel()
    
    private let cheaperStoresView = CheaperStoresView()
    
    private var shopsData: [Shop] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        backgroundColor = .backgroundColor
        
        addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.addSubview(thumbnailImageView)
        scrollView.addSubview(titleReleaseDateStackView)

        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.clipsToBounds = true;
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.layer.borderWidth = 1
        thumbnailImageView.layer.borderColor = UIColor.clear.cgColor
        
        titleReleaseDateStackView.axis = .vertical
        titleReleaseDateStackView.alignment = .leading
        titleReleaseDateStackView.distribution = .fillEqually
        titleReleaseDateStackView.addArrangedSubview(titleLabel)
        titleReleaseDateStackView.addArrangedSubview(releaseDateLabel)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        
        releaseDateLabel.textColor = .subtextColor
        
        scrollView.addSubview(text)
        
        scrollView.addSubview(cheaperStoresLabel)
        cheaperStoresLabel.text = "Cheaper Deals in Other Shops"
        cheaperStoresLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cheaperStoresLabel.textColor = .white
        
        scrollView.addSubview(cheaperStoresView)
        
        
        
    }
    
    private func setLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalTo(self).inset(15)
            make.height.equalTo(200)
        }
        
        titleReleaseDateStackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(30)
            make.leading.trailing.equalTo(self).inset(30)
        }
        
        text.snp.makeConstraints { make in
            make.top.equalTo(titleReleaseDateStackView.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(-15)
            make.trailing.equalTo(self).inset(15)
            make.height.equalTo(200)
        }
        
        cheaperStoresLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(text.snp.bottom).offset(40)
        }
        
        cheaperStoresView.snp.makeConstraints { make in
            make.top.equalTo(cheaperStoresLabel.snp.bottom).offset(30)
            make.leading.trailing.equalTo(self).inset(20)
            make.height.equalTo(0)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    private func setImageConstraint() {
        if thumbnailImageView.image == nil {
            return
        }
        
        let myImageWidth = thumbnailImageView.image!.size.width
        let myImageHeight = thumbnailImageView.image!.size.height
        let myViewWidth = frame.size.width - 30

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        
        thumbnailImageView.snp.updateConstraints { (make) in
            make.height.equalTo(scaledHeight)
        }
    }
    
    func setCollectionViewHeight() {
        cheaperStoresView.snp.updateConstraints { make in
            make.height.equalTo(self.cheaperStoresView.getCollectionViewContentHeight())
        }
    }    
    
    func loadShopsData(shops: [Shop]) {
        self.shopsData = shops
        cheaperStoresView.loadShopsData(shops: shops)
    }
    
    
    func setup(detailedDeal: DetailedDeal) {
        titleLabel.text = detailedDeal.gameInfo.name
        
        let dateFormatter = DateTimeServiceImpl()
        releaseDateLabel.text = "Release Date: " + dateFormatter.stringify(detailedDeal.gameInfo.releaseDate)
        
        if let thumb = detailedDeal.gameInfo.thumb {
            thumbnailImageView.image = UIImage(data: thumb)
            self.setImageConstraint()
            self.thumbnailImageView.layer.borderColor = UIColor.filterHorizontalLineColor.cgColor
        }
    
        
        text.loadDetailsData(currentPrice: detailedDeal.gameInfo.salePrice, priceBeforeSale: detailedDeal.gameInfo.retailPrice, rating: Int(detailedDeal.gameInfo.steamRatingPercent ?? "0") ?? 0, metacritic: Int(detailedDeal.gameInfo.metacriticScore) ?? 0)
        
        cheaperStoresView.loadData(cheaperStores: detailedDeal.cheaperStores)
    }
}
