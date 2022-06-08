//
//  SearchViewController.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController, SearchBoxDelegate, LikeDealDelegate {
    func likeDeal(dealId: String, like: Bool) {
        dealsRepository.likeDeal(dealId: dealId, like: like) { result in
            self.loadData()
        }
    }
    
    func onSearchBoxChange(input: String) {
        timer?.invalidate()
        lastQuery = input
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(loadSearchResultsWithData), userInfo: nil, repeats: false)
    }
    
    func onSearchBoxFocus() {
        label.isHidden = true
        recommended.isHidden = true
        searchView.isHidden = false
    }
    
    func onSearchBoxUnfocus() {
        loadData()
        searchView.isHidden = true
        label.isHidden = false
        recommended.isHidden = false
    }
    
    private var detailsViewController: DetailsViewController
    private var dealsRepository: DealsRepository
    var appRouter: AppRouter?
    private let searchBarView = SearchBarView()
    private let recommended = RecommendedView()
    private let searchView = SearchView()
    private let label = UILabel()
    private let statusBarColorView = UIView()
    private var searchResultsSpinner = UIActivityIndicatorView(style: .large)
    private var timer: Timer?
    private var lastQuery: String = ""
    private var numberOfAttempts = 0
    
  
    init(dealsRepository: DealsRepository, detailsViewController: DetailsViewController) {
        self.dealsRepository = dealsRepository
        self.detailsViewController = detailsViewController
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func buildViews() {
        view.addSubview(statusBarColorView)
        statusBarColorView.backgroundColor = .navbarBackgroundColor
        
        view.backgroundColor = .filterViewBackground
        view.addSubview(label)
        label.text = "Favorite Games"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        searchBarView.delegate = self
        view.addSubview(searchBarView)
        view.addSubview(recommended)
        view.addSubview(searchView)
        
        searchView.isHidden = true
        searchView.likeDealDelegate = self
        searchView.dealclickDelegate = self
        recommended.likeDealDelegate = self
        recommended.dealclickDelegate = self
        
        searchResultsSpinner.isHidden = true
        searchView.addSubview(searchResultsSpinner)
        searchResultsSpinner.backgroundColor = .spinnerBackgroundColor
        searchResultsSpinner.color = .searchAccentColor
    }
    
    private func setLayout() {
        statusBarColorView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        searchBarView.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        label.snp.makeConstraints {make in
            make.top.equalTo(searchBarView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(searchBarView.snp.bottom).offset(30)
        }
        searchView.snp.makeConstraints {make in
            make.top.equalTo(searchBarView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        recommended.snp.makeConstraints {make in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

        }
        
        searchResultsSpinner.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    @objc private func loadSearchResultsWithData() {
        searchResultsSpinner.startAnimating()
        searchResultsSpinner.isHidden = false
        
        dealsRepository.getListOfDeals(parameters: ListOfDealsParameters(title: lastQuery)) { result in
            switch(result) {
            case .success(let deals):
                DispatchQueue.main.sync {
                    self.numberOfAttempts += 1
                    if self.numberOfAttempts > 1 || deals.count > 0 {
                        self.searchResultsSpinner.isHidden = true
                        self.searchResultsSpinner.stopAnimating()
                        self.numberOfAttempts = 0
                    }
                   
                    self.searchView.loadData(dealsData: deals)
                }
            default:
                self.searchResultsSpinner.isHidden = true
                self.searchResultsSpinner.stopAnimating()
                self.numberOfAttempts = 0
                return
            }
        }
    }

    private func loadData() {
        dealsRepository.getLikedDeals() {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.async {
                    self.recommended.loadData(dealsData: data)
                }
            default:
                return
            }
        }
    }
}

extension SearchViewController: DealClickDelegate {
    func dealClicked(dealId: String) {
        appRouter?.showDeal(dealId)
    }
}
