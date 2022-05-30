//
//  ViewController.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var subview: UIView!
    private var dummyRepository: DummyRepository

    init(dummyRepository: DummyRepository) {
        self.dummyRepository = dummyRepository
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subview = DemoView()
        view.addSubview(subview)
        subview.snp.makeConstraints{ make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }

    func getData() -> [DummyThing] {
        return dummyRepository.getData()
    }

}

