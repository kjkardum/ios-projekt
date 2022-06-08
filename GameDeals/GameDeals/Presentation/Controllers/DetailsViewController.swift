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
    var appRouter: AppRouter?
        
    private var detailedDeal: DetailedDeal?
    
    private var isLoading = false
    
    private var spinner = UIActivityIndicatorView(style: .large)
    let alert = UIAlertController(title: "Network error occured!", message: "An error occured while fetching deal data.", preferredStyle: UIAlertController.Style.alert)

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
    
    override func viewWillAppear(_ animated: Bool) {
        detailsView.setCollectionViewHeight()
        alert.dismiss(animated: false) {}
        
        if isLoading {
            detailsView.isHidden = true
            spinner.backgroundColor = .spinnerBackgroundColor
            spinner.color = .searchAccentColor
            spinner.startAnimating()
            spinner.isHidden = false
        }
        
    }
    
    private func buildViews() {
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.cancel) {action in
            self.appRouter?.popBack()
        })
        
        view.addSubview(statusBarColorView)
        statusBarColorView.backgroundColor = .navbarBackgroundColor
        
        view.backgroundColor = .backgroundColor
        
        view.addSubview(detailsView)
        
        view.addSubview(spinner)
        spinner.isHidden = true
        detailsView.isHidden = true
        
    }
    
    private func setLayout() {
        statusBarColorView.snp.makeConstraints{ make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        detailsView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview() 
        }
        
        spinner.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalToSuperview()
        }
        
    }
    
    func loadData(dealId: String) {
        isLoading = true
        
        dealsRepository.getDeal(id: dealId) { result in
            self.isLoading = false
            DispatchQueue.main.async {
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
            }
            
            switch(result) {
            case .success(let data):
                DispatchQueue.main.async {
                    self.detailsView.setup(detailedDeal: data)
                    self.detailsView.isHidden = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.present(self.alert, animated: true, completion: nil)
                }
            }
        }
        
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
    }
}
