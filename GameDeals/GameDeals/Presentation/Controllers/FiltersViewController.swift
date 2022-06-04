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
    private let stackView = UIStackView()
    private let storeFilter = FilterWrapperView<Int>(title: "Shops",
                                                selectionView: FilterSelectionView(isMultiselect: true))
    private let sortByFilter = FilterWrapperView<GameSortingEnum>(title: "Sort By",
                                                selectionView: FilterSelectionView(isMultiselect: false),
                                                additionalSelectionView: UISegmentedControl(items: ["Descending", "Ascending"]))
    private let priceFilter = FilterWrapperView<Int>(title: "Price", sliderView: FilterSliderView()) // Treba enum
    private let metacriticFilter = FilterWrapperView<Int>(title: "Metacritic Rating", sliderView: FilterSliderView(fullyContinuous: true, upperLimit: 100))
    private let steamFilter = FilterWrapperView<Int>(title: "Steam Rating", sliderView: FilterSliderView(fullyContinuous: true, upperLimit: 100))
    
    weak var filterDelegate: FilterDelegate?
    
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
        
        view.addSubview(actionButtons)
        actionButtons.actionButtonsDelegate = self
        
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(filtersLabel)
        
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(storeFilter)
        
        stackView.addArrangedSubview(sortByFilter)
        
        stackView.addArrangedSubview(priceFilter)
        
        stackView.addArrangedSubview(metacriticFilter)
        
        stackView.addArrangedSubview(steamFilter)
        
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        actionButtons.snp.makeConstraints {make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(75)
        }
        
        scrollView.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.bottom.equalTo(actionButtons.snp.top)
            make.leading.trailing.equalToSuperview()
            
        }
        
        filtersLabel.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(filtersLabel.snp.bottom).offset(20)
            make.leading.width.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func loadData() {
        sortByFilter.loadSelectionViewWithData(data: GameSortingEnum.asList().map {game in
            return StringWithKey<GameSortingEnum>(id: game, name: GameSortingEnum.title(game))
        })
        priceFilter.loadSliderViewWithData(data: PriceRangeEnum.asList().map {price in
            return StringWithKey<Int>(id: price.rawValue, name: PriceRangeEnum.title(price))
        })
    
    }
    
    private func getData() {
        var listOfParameters = ListOfDealsParameters()
        
        let sortByFilterValues = sortByFilter.getSelectionViewData()
        if sortByFilterValues.count > 0 {
            listOfParameters.sortBy = sortByFilterValues[0].id
        }
        
        if let sortByCheckboxValue = sortByFilter.getAdditionalSelectionViewValue() {
            listOfParameters.desc = sortByCheckboxValue
        }
        
        if let priceData = priceFilter.getSliderViewData() {
            listOfParameters.upperPrice = priceData.id
        }
        
        if let metacriticRating = metacriticFilter.getSliderViewValue() {
            listOfParameters.metacritic = metacriticRating
        }
        
        if let steamRating = steamFilter.getSliderViewValue() {
            listOfParameters.steamRating = steamRating
        }
        
        filterDelegate?.acceptFilters(listOfParameters)
    }
}

extension FilterViewController: FilterActionButtonsDelegate {
    func clearButtonPressed() {
        storeFilter.resetData()
        sortByFilter.resetData()
        priceFilter.resetData()
        metacriticFilter.resetData()
        steamFilter.resetData()
        dismiss(animated: true, completion: nil)
    }
    
    func applyButtonPressed() {
        getData()
        dismiss(animated: true, completion: nil)
    }
}
