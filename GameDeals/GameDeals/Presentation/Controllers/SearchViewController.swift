//
//  SearchViewController.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController, SearchBoxDelegate {
    func onSearchBoxChange(input: String) {
        print("nis")
    }
    
    func onSearchBoxFocus() {
        label.isHidden = true
        recommended.isHidden = true
        searchV.isHidden = false
        recommended.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
        }
    }
    
    func onSearchBoxUnfocus() {
        
        searchV.isHidden = true
        label.isHidden = false
        recommended.isHidden = false
        label.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
            make.bottom.equalTo(search.snp.bottom).offset(30)
        }
        
        recommended.snp.makeConstraints {make in
            make.top.equalTo(label.snp.bottom).offset(15)
        }
    }
    
//    func onSearchBoxChange(input: String) {
//        <#code#>
//    }
    
    private var dealsRepository: DealsRepository
    private let search = SearchBarView()
    private let recommended = RecommendedView()
    private let searchV = SearchView()
    private let label = UILabel()
    private let statusBarColorView = UIView()
  
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
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    private func buildViews() {
        view.addSubview(statusBarColorView)
        statusBarColorView.backgroundColor = .navbarBackgroundColor
        
        view.backgroundColor = .filterViewBackground
        view.addSubview(label)
        label.text = "Games"
        label.textColor = .white
        
        search.delegate = self
        view.addSubview(search)
        view.addSubview(recommended)
        view.addSubview(searchV)
        searchV.isHidden = true
        
        
    }
    
    private func setLayout() {
        statusBarColorView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        search.snp.makeConstraints {make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(10)
        }
        
        label.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(search.snp.bottom).offset(30)
        }
        searchV.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
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
}
    

    private func loadData() {
        dealsRepository.getLikedDeals() {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.async {
                    self.recommended.loadData(dealsData: data)
                    self.searchV.loadData(dealsData: data)
                }
            default:
                return
            }
    }

    }
    
}
//
