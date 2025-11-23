//
//  SettingsRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  VIPER Router for Settings Module
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {

    static func createModule() -> UIViewController {
        let view = SettingsView()
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
