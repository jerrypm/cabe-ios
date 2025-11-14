//
//  TabBarInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  TabBar Interactor
//

import Foundation

class TabBarInteractor {

    // MARK: - Properties
    weak var presenter: TabBarInteractorOutputProtocol?
}

// MARK: - TabBarInteractorProtocol

extension TabBarInteractor: TabBarInteractorProtocol {

    func fetchTabConfiguration() {
        // Return tab configuration
        let tabs = [
            CBTabBarEntity(icon: "calendar.fill", title: "Jadwal"),
            CBTabBarEntity(icon: "lightbulb.fill", title: "Tips")
        ]

        presenter?.didFetchTabConfiguration(tabs)
    }
}
