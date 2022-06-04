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
    let pom = UIView()
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
        addSubview(recommendedCellView)
        
        recommendedCellView.addSubview(img)
        pom.addSubview(titleLabel)
        pom.addSubview(priceLabel)
        recommendedCellView.addSubview(pom)
        
        recommendedCellView.addSubview(button)
        
        img.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .black
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        
        button.setTitle( "like", for: .normal)
        
        button.setTitleColor(.white, for: .normal)

        
        
        recommendedCellView.clipsToBounds = true
        recommendedCellView.layer.cornerRadius = 5
        recommendedCellView.backgroundColor = .lightGray
        
        backgroundColor = .white
    }
    
    private func setLayout() {
        recommendedCellView.snp.makeConstraints {make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
        
        img.snp.makeConstraints {make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(super.snp.leading).offset(40)
            
        }
        titleLabel.snp.makeConstraints {make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(super.snp.centerY)
        }
        priceLabel.snp.makeConstraints {make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(super.snp.centerY)
        }
        
        pom.snp.makeConstraints { make in
            make.leading.equalTo(img.snp.trailing).offset(10)
            make.bottom.top.equalToSuperview()
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
            self.setImageConstraint()
        }
        
        self.titleLabel.text = dealData.title
        self.priceLabel.text = dealData.salePrice + "$"
        
    }
    
}



