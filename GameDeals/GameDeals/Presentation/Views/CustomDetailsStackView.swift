//
//  CustomDetailsStackView.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit
class CustomDetailsStackView: UIView{
    let mainStackView = UIStackView()
    let nameLabel = UILabel()
    let valueLabel = UILabel()
    convenience init() {
        self.init(frame: .zero)
        buildViews()
        setLayout()
    }
    private func buildViews() {
        addSubview(mainStackView)
        
        mainStackView.axis = .vertical
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(valueLabel)
        
    }
    private func setLayout(){
        mainStackView.snp.makeConstraints {make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    func loadData(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }
    
}
