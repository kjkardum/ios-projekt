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
    }
    
    private func registerServices() {
        container.register(NetworkService.self) { _ in NetworkServiceImpl() }
        container.register(DateTimeService.self) { _ in DateTimeServiceImpl() }
    }
    
    private func registerRepositories() {
        container.autoregister(DummyRepository.self, initializer: DummyRepositoryImpl.init)
        container.autoregister(DealsRepository.self, initializer: DealsRepositoryImpl.init)
        container.autoregister(GamesRepository.self, initializer: GamesRepositoryImpl.init)
    }
    
    private func registerDataSources() {
        container.autoregister(NetworkDummyDS.self, initializer: NetworkDummyDSImpl.init)
        container.autoregister(NetworkDealDS.self, initializer: NetworkDealDSImpl.init)
        container.autoregister(NetworkGameDS.self, initializer: NetworkGameDSImpl.init)
    }
    
    private func registerMappingProfiles() {
        container.register(Mapper<DummyThingNO, DummyThing>.self) { _ in DummyThingNOMapper() }
        container.autoregister(Mapper<DealNO, Deal>.self, initializer: DealNOMapper.init)
        container.autoregister(Mapper<DetailedDealNO, DetailedDeal>.self, initializer: DetailedDealNOMapper.init)
        container.register(Mapper<GameNO, Game>.self) { _ in GameNOMapper() }
        container.autoregister(Mapper<DetailedGameNO, DetailedGame>.self, initializer: DetailedGameNOMapper.init)
    }
    
    func getInitialController() -> UIViewController {
        return container.resolve(DealsViewController.self)!
    }
}
