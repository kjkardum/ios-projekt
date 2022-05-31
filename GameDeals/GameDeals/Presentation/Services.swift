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
    }
    
    private func registerRepositories() {
        container.autoregister(DummyRepository.self, initializer: DummyRepositoryImpl.init)
        container.autoregister(DealsRepository.self, initializer: DealsRepositoryImpl.init)
    }
    
    private func registerDataSources() {
        container.autoregister(NetworkDummyDS.self, initializer: NetworkDummyDSImpl.init)
        container.autoregister(NetworkDealDS.self, initializer: NetworkDealDSImpl.init)
    }
    
    private func registerMappingProfiles() {
        container.register(Mapper<DummyThingNO, DummyThing>.self) { _ in DummyThingNOMapper() }
        container.register(Mapper<DealNO, Deal>.self, factory: { _ in DealNOMapper() })
    }
    
    func getInitialController() -> UIViewController {
        return container.resolve(DealsViewController.self)!
    }
}
