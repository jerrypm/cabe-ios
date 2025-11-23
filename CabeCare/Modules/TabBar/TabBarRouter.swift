//
//  TabBarRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Router for TabBar Module
//

import UIKit

class TabBarRouter: TabBarRouterProtocol {

    static func createModule() -> UIViewController {
        let view = TabBarView()
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        let router = TabBarRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        // Create child view controllers
        let scheduleVC = ScheduleRouter.createModule()
        let tipsVC = TipsViewController()
        let settingsVC = SettingsRouter.createModule()

        // Configure tab items
        let tabItems = [
            CBTabBarEntity(icon: "ic_schedule", title: TabBarLK.scheduleTab.localized),
            CBTabBarEntity(icon: "ic_tips", title: TabBarLK.tipsTab.localized),
            CBTabBarEntity(icon: "ic_settings", title: TabBarLK.settingsTab.localized)
        ]

        // Setup tab bar with view controllers
        view.setupTabBar(with: [scheduleVC, tipsVC, settingsVC], tabItems: tabItems)

        return view
    }
}
