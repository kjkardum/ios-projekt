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
    private let scrollView = UIScrollView()
    private let storeFilter = FilterWrapperView(title: "Shops",
                                                selectionView: FilterSelectionView(isMultiselect: true))
    private let sortByFilter = FilterWrapperView(title: "Sort By",
                                                selectionView: FilterSelectionView(isMultiselect: false),
                                                additionalSelectionView: UISegmentedControl(items: ["Ascending", "Descending"]))
    private let priceFilter = FilterWrapperView(title: "Price", sliderView: FilterSliderView())
    private let metacriticFilter = FilterWrapperView(title: "Metacritic Rating", sliderView: FilterSliderView(fullyContinuous: true, upperLimit: 10))
    private let steamFilter = FilterWrapperView(title: "Steam Rating", sliderView: FilterSliderView(fullyContinuous: true, upperLimit: 10))
    
    
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
        filtersLabel.text = "Filters"
        filtersLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(filtersLabel)
        
        view.addSubview(actionButtons)
        actionButtons.actionButtonsDelegate = self
        
        scrollView.addSubview(storeFilter)
        
        scrollView.addSubview(sortByFilter)
        
        scrollView.addSubview(priceFilter)
        
        scrollView.addSubview(metacriticFilter)
        
        scrollView.addSubview(steamFilter)
        
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        actionButtons.snp.makeConstraints {make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        scrollView.snp.makeConstraints {make in
            make.top.leading.width.equalToSuperview()
            make.bottom.equalTo(actionButtons.snp.top)
        }
        
        filtersLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        storeFilter.snp.makeConstraints {make in
            make.top.equalTo(filtersLabel.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
        }
        
        sortByFilter.snp.makeConstraints {make in
            make.top.equalTo(storeFilter.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
        }
        
        priceFilter.snp.makeConstraints {make in
            make.top.equalTo(sortByFilter.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
        }
        
        metacriticFilter.snp.makeConstraints {make in
            make.top.equalTo(priceFilter.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
        }
        
        steamFilter.snp.makeConstraints {make in
            make.top.equalTo(metacriticFilter.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func loadData() {
        sortByFilter.loadSelectionViewWithData(data: [GameSortingEnum.dealRating.rawValue,
                                                      GameSortingEnum.title.rawValue,
                                                      GameSortingEnum.savings.rawValue,
                                                      GameSortingEnum.price.rawValue,
                                                      GameSortingEnum.metacritic.rawValue])
        priceFilter.loadSliderViewWithData(data: ["Under 5", "Under 10", "Under 20", "Under 30", "Under 40", "Under 50", "Over 50"])
    }
    
    
    private func getData() {
        
    }
}

extension FilterViewController: FilterActionButtonsDelegate {
    func clearButtonPressed() {
        storeFilter.resetData()
        sortByFilter.resetData()
        priceFilter.resetData()
        metacriticFilter.resetData()
        steamFilter.resetData()
    }
    
    func applyButtonPressed() {
        print("Apply pressed")
    }
}
