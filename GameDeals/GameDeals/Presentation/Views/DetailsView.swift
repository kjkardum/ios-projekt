//
//  DetailsView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit

class DetailsView: UIView{
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
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(15)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(200)
        }
        
        titleReleaseDateStackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        text.snp.makeConstraints { make in
            make.top.equalTo(titleReleaseDateStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(-15)
            make.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        cheaperStoresLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(text.snp.bottom).offset(40)
        }
        
        cheaperStoresView.snp.makeConstraints { make in
            make.top.equalTo(cheaperStoresLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(0)
            make.width.equalToSuperview().offset(-40)
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
    
    
    func fakeSetup() {        
        titleLabel.text = "Battlefield 3"
        releaseDateLabel.text = "Release Date: 1319500800"
        
        DispatchQueue.global().async {
        if let data = try? Data(contentsOf: URL(string: "https://cdn.steamstatic.com/steam/apps/1238820/header.jpg?t=1614945737")!) {
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data)
                    self.setImageConstraint()
                    self.thumbnailImageView.layer.borderColor = UIColor.filterHorizontalLineColor.cgColor
                }
            }
            
        }
        
        text.loadDetailsData(currentPrice: "39.99", priceBeforeSale: "39.99", rating: 67, metacritic: 89)
        
        cheaperStoresView.loadData(cheaperStores: [DealCheaperStore(dealID: "YGD76K1QmbBlMj5R5pPOSKzz0Y%2F%2BTVDjQpJmjlnLnus%3D", storeID: "25", salePrice: "19.99", retailPrice: "19.99"),
                                                   DealCheaperStore(dealID: "YGD76K1QmbBlMj5R5pPOSKzz0Y%2F%2BTVDjQpJmjlnLnus%3D", storeID: "8", salePrice: "19.99", retailPrice: "19.99"),
                                                   DealCheaperStore(dealID: "YGD76K1QmbBlMj5R5pPOSKzz0Y%2F%2BTVDjQpJmjlnLnus%3D", storeID: "8", salePrice: "19.99", retailPrice: "19.99"),
                                                   DealCheaperStore(dealID: "YGD76K1QmbBlMj5R5pPOSKzz0Y%2F%2BTVDjQpJmjlnLnus%3D", storeID: "8", salePrice: "19.99", retailPrice: "19.99"),
                                                   DealCheaperStore(dealID: "YGD76K1QmbBlMj5R5pPOSKzz0Y%2F%2BTVDjQpJmjlnLnus%3D", storeID: "8", salePrice: "19.99", retailPrice: "19.99")])
        

    }
    
    
    func loadShopsData(shops: [Shop]) {
        self.shopsData = shops
        cheaperStoresView.loadShopsData(shops: shops)
    }
    
    
    func setup(detailedDeal: DetailedDeal) {
        titleLabel.text = detailedDeal.gameInfo.name
        
        if let thumb = detailedDeal.gameInfo.thumb {
            thumbnailImageView.image = UIImage(data: thumb)
        }
    }
    

}
