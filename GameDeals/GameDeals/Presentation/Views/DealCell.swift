//
//  DealCell.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import SnapKit
import UIKit

class DealCell: UICollectionViewCell {
    let dealCellView = UIView()
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let toolbarView = DealCellToolbarView()
    let releaseDateLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        addSubview(dealCellView)
        
        dealCellView.addSubview(thumbnailImageView)
        dealCellView.addSubview(titleLabel)
        dealCellView.addSubview(toolbarView)
        dealCellView.addSubview(releaseDateLabel)

        
        thumbnailImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        releaseDateLabel.textColor = .white
        
        dealCellView.clipsToBounds = true
        dealCellView.layer.cornerRadius = 20
        dealCellView.backgroundColor = .lightGray
        
        backgroundColor = .white
    }
    
    private func setLayout() {
        dealCellView.snp.makeConstraints {make in
            make.top.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        thumbnailImageView.snp.makeConstraints {make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        releaseDateLabel.snp.makeConstraints {make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            
        }
        
        toolbarView.snp.makeConstraints {make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(75)
        }

    }
    
    
    private func setImageConstraint() {
        if thumbnailImageView.image == nil {
            return
        }
        
        let myImageWidth = thumbnailImageView.image!.size.width
        let myImageHeight = thumbnailImageView.image!.size.height
        let myViewWidth = dealCellView.frame.size.width

        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        
        thumbnailImageView.snp.updateConstraints { (make) in
            make.height.equalTo(scaledHeight)
        }
    }
    
    
    func setup(dealData: Deal) {
        
        if let thumb = dealData.thumb {
            self.thumbnailImageView.image = UIImage(data: thumb)
            self.setImageConstraint()
        }
        
        self.titleLabel.text = dealData.title
        
        self.toolbarView.loadToolbarData(currentPrice: dealData.salePrice, priceBeforeSale: dealData.normalPrice, rating: dealData.dealRating)
        
        let date = Date(timeIntervalSince1970: Double(dealData.releaseDate)) // MARK: OVO NE BI SMIJELO BITI OVDJE
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-YYYY" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        releaseDateLabel.text = "Release date: " + strDate
        
    }
    
}
