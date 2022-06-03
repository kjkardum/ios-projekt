//
//  SearchBoxDelegate.swift
//  GameDeals
//
//  Created by Tomislav Žiger  on 01.06.2022..
//


import Foundation
protocol SearchBoxDelegate: AnyObject {
    func onSearchBoxFocus()
    func onSearchBoxUnfocus()
    func onSearchBoxChange(input: String)
}
