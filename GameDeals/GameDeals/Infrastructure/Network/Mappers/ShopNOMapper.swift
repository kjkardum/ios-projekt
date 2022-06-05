//
//  ShopNOMapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 04.06.2022..
//

import UIKit

class ShopNOMapper: Mapper<ShopNO, Shop> {
    override func mapTo(source: ShopNO, destination: inout Shop) -> Shop {
        destination.storeID = Int(source.storeID) ?? 0
        destination.storeName = source.storeName
        destination.isActive = source.isActive
        destination.images = ShopImage(banner: convertUrlToData(source.images.banner),
                                       logo: convertUrlToData(source.images.logo),
                                       icon: convertUrlToData(source.images.icon))
        return destination
    }
    
    override func mapTo(source: Shop, destination: inout ShopNO) -> ShopNO {
        destination.storeID = String(source.storeID)
        destination.storeName = source.storeName
        destination.isActive = source.isActive
        destination.images = ShopImageNO(banner: "", logo: "", icon: "")
        return destination
    }
    
    override func map(_ from: ShopNO) -> Shop {
        var shop = Shop()
        return mapTo(source: from, destination: &shop)
    }
    
    override func map(_ from: Shop) -> ShopNO {
        var shopNO = ShopNO()
        return mapTo(source: from, destination: &shopNO)
    }
    
    private func convertUrlToData(_ partialImageUrl: String) -> Data? {
        let imageUrl = URL(string: "https://www.cheapshark.com" + partialImageUrl)
        let imageData = imageUrl != nil ? try? Data(contentsOf: imageUrl!) : nil
        var thumb: Data? = nil
        DispatchQueue.global(qos: .background).sync {
            let image = imageData != nil ? UIImage(data: imageData!)?.jpegData(compressionQuality: 90) : nil
            thumb = image
        }
        return thumb
    }
}
