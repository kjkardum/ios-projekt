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
        container.autoregister(ViewController.self, initializer: ViewController.init)
    }
    
    private func registerServices() {
        container.register(NetworkService.self) { _ in NetworkServiceImpl() }
    }
    
    private func registerRepositories() {
        container.autoregister(DummyRepository.self, initializer: DummyRepositoryImpl.init)
    }
    
    private func registerDataSources() {
        container.autoregister(NetworkDummyDS.self, initializer: NetworkDummyDSImpl.init)
    }
    
    private func registerMappingProfiles() {
        container.register(Mapper<DummyThingNO, DummyThing>.self) { _ in DummyThingNOMapper() }
    }
    
    func getInitialController() -> UIViewController {
        return container.resolve(ViewController.self)!
    }
}
