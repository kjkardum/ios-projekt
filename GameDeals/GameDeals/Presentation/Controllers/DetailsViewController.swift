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
    private let detailsView = DetailsView()
    
    private var dealsRepository: DealsRepository
    
    private var listOfParameters = ListOfDealsParameters(storeIds: [1])

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
        view.addSubview(detailsView)
        
       
    }
    
    private func setLayout() {
        
        detailsView.snp.makeConstraints {make in
            make.top.trailing.leading.bottom.equalToSuperview()
            }
    }
    private func setDealIdI(id: Int){
        
    }
    
    private func loadData() {
        dealsRepository.getListOfDeals(parameters: listOfParameters) {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.detailsView.loadData(dealsData: data)
                }
            default:
                return
            }
        }
    }
    
    

}

extension DetailsViewController: FilterDelegate {
    func acceptFilters(_ listOfDealsParameters: ListOfDealsParameters) {
        print(listOfDealsParameters)
        self.listOfParameters = listOfDealsParameters
        loadData()
    }
}
