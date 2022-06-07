//
//  DealsViewController.swift
//  GameDeals
//
//  Created by Five on 31.05.2022..
//

import Foundation
import UIKit
import SnapKit


class DealsViewController: UIViewController {
    private let filterModal: FilterViewController
    private let dealsView = DealsView()
    private let filterView = UIView()
    private let statusBarColorView = UIView()
    //private let filterShowButton = UIButton()
    private var dealsRepository: DealsRepository
    private var shopsRepository: ShopsRepository
    private var shops: [Shop] = []
    
    private var listOfParameters = ListOfDealsParameters(sortBy: .recent)

    init(dealsRepository: DealsRepository, shopsRepository: ShopsRepository, filterModal: FilterViewController) {
        self.dealsRepository = dealsRepository
        self.shopsRepository = shopsRepository
        self.filterModal = filterModal
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterModal.filterDelegate = self
        dealsView.likeDealDeleage = self
        buildViews()
        setLayout()
        getShopsAndDealData()
    }
    
    private func buildViews() {
        view.backgroundColor = UIColor.backgroundColor
        view.addSubview(dealsView)
        view.addSubview(filterView)
        
        //view.addSubview(filterShowButton)
        view.addSubview(statusBarColorView)
        /*filterShowButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        filterShowButton.clipsToBounds = true
        filterShowButton.layer.cornerRadius = 10
        filterShowButton.backgroundColor = .backgroundColorAccent
        filterShowButton.setImage(.line3Horizontal, for: .normal)
        filterShowButton.tintColor = .white*/
        
        statusBarColorView.backgroundColor = .navbarBackgroundColor
        
        filterView.backgroundColor = .clear
    }
    
    private func setLayout() {
        statusBarColorView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        filterView.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(50)
        }
        
        dealsView.snp.makeConstraints {make in
            make.top.equalTo(filterView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
        /*filterShowButton.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }*/
    }
    
    
    private func getShopsAndDealData() {
        shopsRepository.getListOfShops { response in
            switch(response) {
            case.success(let data):
                self.shops = data
                self.loadData()
            default:
                return
            }
        }
    }
    
    private func loadData() {
        dealsRepository.getListOfDeals(parameters: listOfParameters) {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.dealsView.loadData(dealsData: data, shops: self.shops)
                }
            default:
                return
            }
        }
    }
    
    func tabBarClickedHome() {
        dealsView.resetCollectionViewPosition()
    }

    
    @objc func click() {
        filterModal.modalPresentationStyle = .formSheet
        present(filterModal, animated: true, completion: nil)
    }

}

extension DealsViewController: FilterDelegate {
    func acceptFilters(_ listOfDealsParameters: ListOfDealsParameters) {
        print(listOfDealsParameters)
        self.listOfParameters = listOfDealsParameters
        loadData()
    }
}

extension DealsViewController: LikeDealDelegate {
    func likeDeal(dealId: String, like: Bool) {
        dealsRepository.likeDeal(dealId: dealId, like: like) { result in
        }
    }
}
