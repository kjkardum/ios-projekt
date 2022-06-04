//
//  Services.swift
//  GameDeals
//
//  Created by Karlo Josip Kardum on 30.05.2022..
//

import Foundation
import Swinject
import SwinjectAutoregistration
import UIKit

class Services {
    let container: Container
    
    init() {
        container = Container()
        // ako nema ni jedan dependency, mora se inicijalizirati sa register, inace se moze koristiti autoregister
        registerMappingProfiles()
        registerDataSources()
        registerRepositories()
        registerServices()
        registerControllers()
    }
            
    private func registerControllers() {
        container.autoregister(DealsViewController.self, initializer: DealsViewController.init)
        container.autoregister(SearchViewController.self, initializer: SearchViewController.init)
    
    }
    
    private func registerServices() {
        container.register(NetworkService.self) { _ in NetworkServiceImpl() }
        container.register(DateTimeService.self) { _ in DateTimeServiceImpl() }
        container.register(CoreDataStack.self) { _ in CoreDataStack() }
    }
    
    private func registerRepositories() {
        container.autoregister(DealsRepository.self, initializer: DealsRepositoryImpl.init)
        container.autoregister(GamesRepository.self, initializer: GamesRepositoryImpl.init)
        container.autoregister(ShopsRepository.self, initializer: ShopsRepositoryImpl.init)
    }
    
    private func registerDataSources() {
        container.autoregister(NetworkDealDS.self, initializer: NetworkDealDSImpl.init)
        container.autoregister(NetworkGameDS.self, initializer: NetworkGameDSImpl.init)
        container.autoregister(DbDealDS.self, initializer: DbDealDSImpl.init)
        container.autoregister(DbGameDS.self, initializer: DbGameDSImpl.init)
        container.autoregister(NetworkShopDS.self, initializer: NetworkShopDSImpl.init)
    }
    
    private func registerMappingProfiles() {
        container.autoregister(Mapper<DealNO, Deal>.self, initializer: DealNOMapper.init)
        container.autoregister(Mapper<DetailedDealNO, DetailedDeal>.self, initializer: DetailedDealNOMapper.init)
        container.register(Mapper<GameNO, Game>.self) { _ in GameNOMapper() }
        container.autoregister(Mapper<DetailedGameNO, DetailedGame>.self, initializer: DetailedGameNOMapper.init)
        container.autoregister(Mapper<DealMO, Deal>.self, initializer: DealMOMapper.init)
        container.register(Mapper<GameMO, Game>.self, factory: { _ in GameMOMapper() })
        container.register(Mapper<ShopNO, Shop>.self, factory: { _ in ShopNOMapper() })
    }
    
    func getInitialController() -> UIViewController {
        return container.resolve(DealsViewController.self)!
    }
}
