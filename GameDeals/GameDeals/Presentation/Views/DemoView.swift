//
//  DemoView.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation
import UIKit
import SnapKit

class DemoView: UIView {
    var demoText: UILabel!
    init() {
        super.init(frame: CGRect())
        buildView()
        setViewLayout()
    }
    
    override func didMoveToSuperview() {
        loadData()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func buildView() {
        backgroundColor = .gray
        demoText = UILabel()
        demoText.textColor = .green
        demoText.numberOfLines = 0
        addSubview(demoText)
    }
    
    func setViewLayout() {
        demoText.snp.makeConstraints{ make in
            make.top.left.equalToSuperview().offset(10)
        }
    }
    
    func loadData() {
        guard let controller: ViewController = findViewController() else { return }
        let data = controller.getData()
        if let first = data.first {
            demoText.text = first.name
        } else {
            demoText.text = "ERROR"
        }
    }
}
