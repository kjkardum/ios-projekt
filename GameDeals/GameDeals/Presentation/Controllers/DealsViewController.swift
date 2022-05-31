//
//  DealsViewController.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import UIKit
import SnapKit

struct TestData {
    let thumb: String
    let title: String
    let dealRating: String
    let normalPrice: String
    let salePrice: String
    let savings: String
    let steamRatingPercent: String
    let metacriticScore: String
    let releaseDate: String
}

class DealsViewController: UIViewController {
    private let dealsView = DealsView()
    private let filterView = UIView() // Privremeno dok ne dođemo do filtera
    private var dummyRepository: DummyRepository

    init(dummyRepository: DummyRepository) {
        self.dummyRepository = dummyRepository
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setLayout()
        loadData()
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        view.addSubview(dealsView)
        view.addSubview(filterView)
        filterView.backgroundColor = .gray
    }
    
    private func setLayout() {
        filterView.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(100)
        }
        
        dealsView.snp.makeConstraints {make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    private func loadData() {
        var data : [TestData] = []
        data.append(TestData(thumb: "https://cdn.cloudflare.steamstatic.com/steam/apps/238010/header.jpg?t=1619788192", title: "Deus Ex: Human Revolution - Director's Cut", dealRating: "9.6", normalPrice: "19.99", salePrice: "2.99", savings: "85.042521", steamRatingPercent: "92", metacriticScore: "91", releaseDate: "953769600"))
        data.append(TestData(thumb: "https://cdn.cloudflare.steamstatic.com/steam/apps/6980/header.jpg?t=1592493801", title: "Thief: Deadly Shadows", dealRating: "9.4", normalPrice: "8.99", salePrice: "0.98", savings: "89.098999", steamRatingPercent: "81", metacriticScore: "85", releaseDate: "1085443200"))
        data.append(TestData(thumb: "https://cdn.cloudflare.steamstatic.com/steam/apps/8190/header.jpg?t=1593180404", title: "Just Cause 2", dealRating: "9.4", normalPrice: "14.99", salePrice: "1.49", savings: "90.060040", steamRatingPercent: "90", metacriticScore: "84", releaseDate: "1269302400"))
        
        dealsView.loadData(dealsData: data)
    }

    func getData() -> [DummyThing] {
        return dummyRepository.getData()
    }

}


