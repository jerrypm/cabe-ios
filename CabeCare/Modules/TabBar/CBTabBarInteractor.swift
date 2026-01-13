//
//  TabBarInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  TabBar Interactor
//

import Foundation

class CBTabBarInteractor {

    // MARK: - Properties
    weak var presenter: CBTabBarInteractorOutputProtocol?
}

// MARK: - CBTabBarInteractorProtocol

extension CBTabBarInteractor: CBTabBarInteractorProtocol {

    func fetchTabConfiguration() {
        // Return tab configuration
        let tabs = [
            CBTabBarEntity(icon: "ic_schedule", title: TabBarLK.scheduleTab.localized),
            CBTabBarEntity(icon: "ic_tips", title: TabBarLK.tipsTab.localized),
            CBTabBarEntity(icon: "ic_settings", title: TabBarLK.settingsTab.localized)
        ]

        presenter?.didFetchTabConfiguration(tabs)
    }
}
