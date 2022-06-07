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
    
    let detailsView = UIView()
    let detailsText = UIView()
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    let buttonAdd = UIButton()
    let text = DetailsText()
    weak var scrollViewDelegate: ScrollableCollectionViewDelegate?
    var dealsData : [Deal] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        
        addSubview(detailsView)
        
        
        detailsView.addSubview(thumbnailImageView)
        detailsView.addSubview(titleLabel)
        
        detailsView.addSubview(text)
        detailsView.addSubview(buttonAdd)

        thumbnailImageView.contentMode = .scaleAspectFill;
        thumbnailImageView.clipsToBounds = true;
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        releaseDateLabel.textColor = .white
        
        detailsView.clipsToBounds = true
        detailsView.layer.cornerRadius = 20
        detailsView.backgroundColor = .lightGray
        
        buttonAdd.backgroundColor = .orange
        buttonAdd.setTitleColor(.black, for: .normal)
        buttonAdd.setTitle("ADD", for: .normal)
        backgroundColor = .gray
    }
    
    private func setLayout() {
        
        
        thumbnailImageView.snp.makeConstraints {make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(168)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        
        
        
        buttonAdd.snp.makeConstraints {make in
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
        let myViewWidth = detailsView.frame.size.width

        let ratio = myViewWidth/myImageWidth
        var scaledHeight = myImageHeight * ratio
        
        if scaledHeight > 168 {
            scaledHeight = 168
        }
        
        thumbnailImageView.snp.updateConstraints { (make) in
            make.height.equalTo(scaledHeight)
        }
    }
    
    func loadData(dealsData: [Deal]) {
        self.dealsData = dealsData
    }
    func setup(dealData: Deal) {
        
        if let thumb = dealData.thumb {
            self.thumbnailImageView.image = UIImage(data: thumb)
            self.setImageConstraint()
        }
        
        self.titleLabel.text = dealData.title
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-YYYY" //Specify your format that you want
        let strDate = dateFormatter.string(from: dealData.releaseDate)
        releaseDateLabel.text = "Release date: " + strDate
        
        
    }
    
}
