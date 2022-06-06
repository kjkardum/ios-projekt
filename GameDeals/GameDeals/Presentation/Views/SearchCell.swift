//
//  SearchCell.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import Foundation
import UIKit
import SnapKit

    
class SearchCell: UICollectionViewCell {
    let searchCellView = UIView()
    let img = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
   
    var pom = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        addSubview(searchCellView)
        searchCellView.addSubview(img)
        pom.addSubview(titleLabel)
        pom.addSubview(priceLabel)
        searchCellView.addSubview(pom)
        
        
        img.contentMode = .scaleAspectFit
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .black
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
       
        
        
        
        searchCellView.clipsToBounds = true
        searchCellView.layer.cornerRadius = 5
        searchCellView.backgroundColor = .clear
        
        backgroundColor = .filterViewBackground
    }
    
    private func setLayout() {
        searchCellView.snp.makeConstraints {make in
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
            make.trailing.equalTo(super.snp.trailing).offset(-10)
            
        }
       
        
        
        

    }
    
    
    private func setImageConstraint() {
        if img.image == nil {
            return
        }
        
        let myImageWidth = img.image!.size.width
        let myImageHeight = img.image!.size.height
        let myViewWidth = searchCellView.frame.size.width

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



