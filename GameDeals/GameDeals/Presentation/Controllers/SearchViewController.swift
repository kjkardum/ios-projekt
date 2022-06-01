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
        recommended.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
        }
    }
    
    func onSearchBoxUnfocus() {
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
    private let label = UILabel()
  
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
        view.addSubview(label)
        label.text = "Games"
        
        search.delegate = self
        view.addSubview(search)
        view.addSubview(recommended)
        
        
        
    }
    
    private func setLayout() {
        search.snp.makeConstraints {make in
        make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
        make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        
    }
        label.snp.makeConstraints {make in
            make.top.equalTo(search.snp.bottom).offset(15)
        make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
        make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        make.bottom.equalTo(search.snp.bottom).offset(30)
        
    }
        recommended.snp.makeConstraints {make in
        make.top.equalTo(label.snp.bottom).offset(15)
        make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
        make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
        make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)

    }
}
    

    private func loadData() {
        dealsRepository.getListOfDeals(parameters: ListOfDealsParameters(upperPrice: 15)) {response in
            switch (response) {
            case .success(let data):
                DispatchQueue.main.sync {
                    self.recommended.loadData(dealsData: data)
                }
            default:
                return
            }
    }

    }
    
}
//
