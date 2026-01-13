//
//  CBSettingsRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  VIPER Router for Settings Module
//

import UIKit

class CBSettingsRouter: CBSettingsRouterProtocol {

    static func createModule() -> UIViewController {
        let view = CBSettingsView()
        let presenter = CBSettingsPresenter()
        let interactor = CBSettingsInteractor()
        let router = CBSettingsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }
}
