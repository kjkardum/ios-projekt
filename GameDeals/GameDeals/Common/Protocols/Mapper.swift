//
//  Mapper.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation

class Mapper<TEntity, TModel> {
    func map(_:TEntity) -> TModel {
        fatalError("Mapper should be used as abstract class")
    }
    
    func map(_:TModel) -> TEntity {
        fatalError("Mapper should be used as abstract class")
    }
    
    func mapTo(source:TEntity, destination: inout TModel) -> TModel {
        fatalError("Mapper should be used as abstract class")
    }
    
    func mapTo(source:TModel, destination: inout TEntity) -> TEntity {
        fatalError("Mapper should be used as abstract class")
    }
    
}
