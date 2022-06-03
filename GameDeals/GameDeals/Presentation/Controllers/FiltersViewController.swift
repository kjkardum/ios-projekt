//
//  FiltersViewController.swift
//  GameDeals
//
//  Created by Five on 02.06.2022..
//

import Foundation
import UIKit
import SnapKit

class FilterViewController: UIViewController {
    private var dealsRepository: DealsRepository
    private let actionButtons = ActionButtonsForFiltersView()
    private let filtersLabel = UILabel()
    private let storeFilter = FilterWrapperView(title: "Shops", selectionView: FilterSelectionView(isMultiselect: true, cellStyle: .standard))
    
    
    init(dealsRepository: DealsRepository) {
        self.dealsRepository = dealsRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setLayout()
    }
    
    private func buildViews() {
        filtersLabel.text = "Filters"
        filtersLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(filtersLabel)
        
        view.addSubview(actionButtons)
        
        view.addSubview(storeFilter)
        
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        filtersLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        storeFilter.snp.makeConstraints {make in
            make.top.equalTo(filtersLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(150)
        }
        
        
        actionButtons.snp.makeConstraints {make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
    }
}
