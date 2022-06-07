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
        container.autoregister(TabBarViewController.self, initializer: TabBarViewController.init)
        container.autoregister(DealsViewController.self, initializer: DealsViewController.init)
        container.autoregister(SearchViewController.self, initializer: SearchViewController.init)
        container.autoregister(FilterViewController.self, initializer: FilterViewController.init)
        container.autoregister(DetailsViewController.self, initializer: DetailsViewController.init)
    
    }
    
    private func registerServices() {
        container.register(NetworkService.self) { _ in NetworkServiceImpl() }
        container.register(DateTimeService.self) { _ in DateTimeServiceImpl() }
        container.register(CoreDataStack.self) { _ in CoreDataStack() }
        container.autoregister(AppRouter.self, initializer: AppRouter.init)
    }
    
    private func registerRepositories() {
        container.autoregister(DealsRepository.self, initializer: DealsRepositoryImpl.init)
        container.autoregister(GamesRepository.self, initializer: GamesRepositoryImpl.init)
        container.autoregister(ShopsRepository.self, initializer: ShopsRepositoryImpl.init)
    }
    
    private func registerDataSources() {
        container.autoregister(NetworkDealDS.self, initializer: NetworkDealDSImpl.init)
        container.autoregister(DbDealDS.self, initializer: DbDealDSImpl.init)
        container.autoregister(NetworkGameDS.self, initializer: NetworkGameDSImpl.init)
        container.autoregister(DbGameDS.self, initializer: DbGameDSImpl.init)
        container.autoregister(NetworkShopDS.self, initializer: NetworkShopDSImpl.init)
        container.autoregister(DbShopDS.self, initializer: DbShopDSImpl.init)
    }
    
    private func registerMappingProfiles() {
        container.autoregister(Mapper<DealNO, Deal>.self, initializer: DealNOMapper.init)
        container.autoregister(Mapper<DealMO, Deal>.self, initializer: DealMOMapper.init)
        container.autoregister(Mapper<DetailedDealNO, DetailedDeal>.self, initializer: DetailedDealNOMapper.init)
        container.autoregister(Mapper<DetailedGameNO, DetailedGame>.self, initializer: DetailedGameNOMapper.init)
        container.register(Mapper<GameNO, Game>.self) { _ in GameNOMapper() }
        container.autoregister(Mapper<GameMO, Game>.self, initializer: GameMOMapper.init)
        container.register(Mapper<ShopNO, Shop>.self, factory: { _ in ShopNOMapper() })
        container.autoregister(Mapper<ShopMO, Shop>.self, initializer: ShopMOMapper.init)
    }
    
    func getAppRouter() -> AppRouter {
        return container.resolve(AppRouter.self)!
    }
    
    func getDealsViewController() -> DealsViewController {
        return container.resolve(DealsViewController.self)!
    }
    
    func getFilterViewController() -> FilterViewController {
        return container.resolve(FilterViewController.self)!
    }
    
    func getSearchViewController() -> SearchViewController {
        return container.resolve(SearchViewController.self)!
    }
}
