//
//  DetailsViewController.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 07.06.2022..
//

import Foundation
import UIKit
import SnapKit


class DetailsViewController: UIViewController {
    private let statusBarColorView = UIView()
    
    private let detailsView = DetailsView()
    
    private var dealsRepository: DealsRepository
    private var shopsRepository: ShopsRepository
        
    private var detailedDeal: DetailedDeal?
    
    private var spinner = UIActivityIndicatorView(style: .large)

    init(dealsRepository: DealsRepository, shopsRepository: ShopsRepository) {
        self.dealsRepository = dealsRepository
        self.shopsRepository = shopsRepository
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        detailsView.setCollectionViewHeight()
    }
    
    private func buildViews() {
        
        view.addSubview(statusBarColorView)
        statusBarColorView.backgroundColor = .navbarBackgroundColor
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(detailsView)
        
        
        detailsView.addSubview(spinner)
        spinner.backgroundColor = .spinnerBackgroundColor
        spinner.color = .searchAccentColor
        
        
    }
    
    private func setLayout() {
        statusBarColorView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        spinner.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    func loadData(dealId: String) {
        DispatchQueue.main.async {
            self.spinner.startAnimating()
            self.spinner.isHidden = false
        }
        
        
        dealsRepository.getDeal(id: dealId) { result in
            switch(result) {
            case .success(let data):
                DispatchQueue.main.async {
                    self.detailsView.setup(detailedDeal: data)
                }
            default:
                return
            }
        }
        
        detailsView.fakeSetup()
        

        
        shopsRepository.getListOfShops { result in
            switch(result) {
            case .success(let data):
                DispatchQueue.main.async {
                    self.detailsView.loadShopsData(shops: data)
                }
                
            default:
                return
            }
        }
        
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
        
        
    }
}
