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
    private let dealsView = DealsView()
    private let filterView = UIView() // Privremeno dok ne dođemo do filtera
    private var dealsRepository: DealsRepository

    init(dealsRepository: DealsRepository) {
        self.dealsRepository = dealsRepository
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
        dealsRepository.getListOfDeals(parameters: ListOfDealsParameters(upperPrice: 15)) {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.dealsView.loadData(dealsData: data)
                }
            default:
                return
            }
        }
    }

}


