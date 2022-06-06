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
    
    let dealInfoStackView = UIStackView()
    let titleLabel = UILabel()
    let releaseDateLabel = UILabel()
    
    let shopInfoStackView = UIStackView()
    let shopLabel = UILabel()
    let shopImageView = UIImageView()
    
    let shopTitleAndChangeStackView = UIStackView()
    let shopTitleLabel = UILabel()
    let dealLastChanged = UILabel()
    
    let toolbarView = DealCellToolbarView()
    
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
        addSubview(shopInfoStackView)
        
        likeView.addSubview(heartIconView)
        
        dealCellView.addSubview(thumbnailImageView)
        dealCellView.addSubview(dealInfoStackView)
        
        dealInfoStackView.axis = .vertical
        dealInfoStackView.distribution = .fill
        dealInfoStackView.alignment = .top
        dealInfoStackView.spacing = 5
        dealInfoStackView.addArrangedSubview(titleLabel)
        dealInfoStackView.addArrangedSubview(releaseDateLabel)
        
        dealInfoStackView.addArrangedSubview(UIView())
        
        dealCellView.addSubview(toolbarView)

        thumbnailImageView.contentMode = .scaleAspectFill;
        thumbnailImageView.clipsToBounds = true;
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleLabel.textColor = .white
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 3
        
        releaseDateLabel.textColor = UIColor.subtextColor
        releaseDateLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        shopInfoStackView.axis = .horizontal
        shopInfoStackView.distribution = .fill
        shopInfoStackView.alignment = .center
        shopInfoStackView.spacing = 10

        shopInfoStackView.addArrangedSubview(shopImageView)
        shopInfoStackView.addArrangedSubview(shopTitleAndChangeStackView)
        shopInfoStackView.addArrangedSubview(UIView())
        
        
        shopTitleAndChangeStackView.addArrangedSubview(shopTitleLabel)
        shopTitleAndChangeStackView.addArrangedSubview(dealLastChanged)
        
        shopTitleAndChangeStackView.axis = .vertical
        shopTitleAndChangeStackView.distribution = .fillEqually
        shopTitleAndChangeStackView.alignment = .leading
        
        dealLastChanged.textColor = .white
        dealLastChanged.font = UIFont.systemFont(ofSize: 14)
        
        shopLabel.textColor = .white
        shopLabel.text = "Shop: "
        
        shopImageView.clipsToBounds = true
        shopImageView.layer.cornerRadius = 10
        
        shopTitleLabel.textColor = .white
        shopTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        dealCellView.clipsToBounds = true
        dealCellView.layer.cornerRadius = 20
        dealCellView.backgroundColor = UIColor.backgroundColorCell
        
        likeView.clipsToBounds = true
        likeView.layer.cornerRadius = dealCellView.layer.cornerRadius
        
        backgroundColor = .clear
    }
    
    private func setLayout() {
        shopInfoStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        likeView.snp.makeConstraints {make in
            make.top.equalTo(shopInfoStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        heartIconView.snp.makeConstraints {make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        dealCellView.snp.makeConstraints {make in
            make.top.equalTo(shopInfoStackView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().inset(15)
        }
        
        toolbarView.snp.makeConstraints {make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(75)
        }
        
        thumbnailImageView.snp.makeConstraints {make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(204)
        }
        
        dealInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(toolbarView.snp.top).inset(30)
        }
        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(thumbnailImageView.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().inset(30)
//        }
//
//        releaseDateLabel.snp.makeConstraints {make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(30)
//
//        }
        
        

    }
    
    @objc func handleGesture(_ gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            gestureIsEnabled = true
            pointOrigin = self.dealCellView.frame.origin
        }
        
        let translation = gesture.translation(in: dealCellView)
    
        
        if gesture.state == .ended || gesture.state == .cancelled || gesture.state == .possible {
            UIView.animate(withDuration: 0.3) {
                self.dealCellView.frame.origin = self.pointOrigin!
                self.scrollViewDelegate?.setScrollViewEnabled(true)
            }
        }
        
        guard translation.y >= 0 else { return }
        
        
        
        if dealCellView.frame.origin.y > 120 {
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
        
        // CGRectContainsPoint(self.pannableView.frame, pan.locationInView(self.pannableView)) -> moguce za buducnost

        if gesture.state == .changed {
            dealCellView.frame.origin = CGPoint(x: dealCellView.frame.origin.x, y: self.pointOrigin!.y + translation.y)
        }
    }
    
    
    func setup(dealData: Deal, shopData: Shop?) {
        
        if let thumb = dealData.thumb {
            self.thumbnailImageView.image = UIImage(data: thumb)
        }
        
        self.titleLabel.text = dealData.title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.toolbarView.loadToolbarData(currentPrice: dealData.salePrice, priceBeforeSale: dealData.normalPrice, steamRating: dealData.steamRatingPercent, metaCriticRating: dealData.metacriticScore, dealRating: dealData.dealRating)
    
        let dateFormatter = DateTimeServiceImpl()
        releaseDateLabel.text = "Release date: " + dateFormatter.stringify(dealData.releaseDate)
        
        if let shopData = shopData {
            shopTitleLabel.text = shopData.storeName
            let dateFormatter = DateTimeServiceImpl()
            dealLastChanged.text = dateFormatter.stringify(dealData.lastChange)
            if let shopImage = shopData.images.logo {
                shopImageView.image = UIImage(data: shopImage)
                shopImageView.snp.makeConstraints { make in
                    make.width.height.equalTo(40)
                }
            }
        }
        
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
        } else {
            scrollViewDelegate?.setScrollViewEnabled(true)
        }
        return abs(gesture.velocity(in: dealCellView).y) > abs(gesture.velocity(in: dealCellView).x)
    }
}
