//
//  DealCell.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import SnapKit
import UIKit
import SFSafeSymbols

class DealCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    let dealCellView = UIView()
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    let toolbarView = DealCellToolbarView()
    let releaseDateLabel = UILabel()
    var gesture = UIPanGestureRecognizer()
    var pointOrigin: CGPoint?
    let likeView = UIView()
    let heartIconView = UIImageView()
    var likeState = false
    var gestureIsEnabled = false
    
    weak var scrollViewDelegate: ScrollableCollectionViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        buildViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        gesture = UIPanGestureRecognizer(target: self, action: #selector(DealCell.handleGesture(_:)))
        gesture.delegate = self
        dealCellView.addGestureRecognizer(gesture)
        dealCellView.isUserInteractionEnabled = true
        
        addSubview(likeView)
        addSubview(dealCellView)
        
        likeView.addSubview(heartIconView)
        
        dealCellView.addSubview(thumbnailImageView)
        dealCellView.addSubview(titleLabel)
        dealCellView.addSubview(toolbarView)
        dealCellView.addSubview(releaseDateLabel)

        thumbnailImageView.contentMode = .scaleAspectFill;
        thumbnailImageView.clipsToBounds = true;
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        releaseDateLabel.textColor = .white
        
        dealCellView.clipsToBounds = true
        dealCellView.layer.cornerRadius = 20
        dealCellView.backgroundColor = .lightGray
        
        likeView.clipsToBounds = true
        likeView.layer.cornerRadius = dealCellView.layer.cornerRadius
        
        backgroundColor = .white
    }
    
    private func setLayout() {
        likeView.snp.makeConstraints {make in
            make.top.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        heartIconView.snp.makeConstraints {make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        dealCellView.snp.makeConstraints {make in
            make.top.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        thumbnailImageView.snp.makeConstraints {make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(168)
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
    
    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            gestureIsEnabled = true
            pointOrigin = self.dealCellView.frame.origin
        }
        
        let translation = gesture.translation(in: dealCellView)
        
        guard translation.y >= 0 else { return }
        
        if dealCellView.frame.origin.y > 100 {
            self.userSwiped()
            gestureIsEnabled = false
            UIView.animate(withDuration: 0.3) {
                gesture.isEnabled = false
                self.dealCellView.frame.origin = self.pointOrigin!
                gesture.isEnabled = true
                self.scrollViewDelegate?.setScrollViewEnabled(true)
                return
            }

        }

        if gesture.state == .changed {
            dealCellView.frame.origin = CGPoint(x: dealCellView.frame.origin.x, y: self.pointOrigin!.y + translation.y)
        }
        

        if gesture.state == .ended || gesture.state == .cancelled {
            UIView.animate(withDuration: 0.3) {
                self.dealCellView.frame.origin = self.pointOrigin!
                self.scrollViewDelegate?.setScrollViewEnabled(true)
            }
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
        var scaledHeight = myImageHeight * ratio
        
        if scaledHeight > 168 {
            scaledHeight = 168
        }
        
        thumbnailImageView.snp.updateConstraints { (make) in
            make.height.equalTo(scaledHeight)
        }
    }
    
    
    func setup(dealData: Deal) {
        
        if let thumb = dealData.thumb {
            self.thumbnailImageView.image = UIImage(data: thumb)
//            self.setImageConstraint()
        }
        
        self.titleLabel.text = dealData.title
        
        self.toolbarView.loadToolbarData(currentPrice: dealData.salePrice, priceBeforeSale: dealData.normalPrice, rating: dealData.dealRating)
    
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd-MM-YYYY" //Specify your format that you want
        let strDate = dateFormatter.string(from: dealData.releaseDate)
        releaseDateLabel.text = "Release date: " + strDate
        
        if likeState {
            self.heartIconView.image = UIImage(systemSymbol: .heartFill)
        } else {
            self.heartIconView.image = UIImage(systemSymbol: .heart)
        }
        
        pointOrigin = self.dealCellView.frame.origin
    }
    
    
    func userSwiped() {
        if (gestureIsEnabled) {
            if self.likeState {
                self.likeState = false
                self.heartIconView.image = UIImage(systemSymbol: .heart)
            } else {
                self.likeState = true
                self.heartIconView.image = UIImage(systemSymbol: .heartFill)
            }
            
            
        }
    }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if abs(gesture.velocity(in: dealCellView).y) > abs(gesture.velocity(in: dealCellView).x) {
            scrollViewDelegate?.setScrollViewEnabled(false)
        }
        return abs(gesture.velocity(in: dealCellView).y) > abs(gesture.velocity(in: dealCellView).x)
    }
}
