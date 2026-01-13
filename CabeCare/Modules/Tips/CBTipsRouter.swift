//
//  CBTipsRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Router for Tips Module
//

import UIKit

class CBTipsRouter: CBTipsRouterProtocol {

    static func createModule() -> UIViewController {
        let view = CBTipsView()
        let presenter = CBTipsPresenter()
        let interactor = CBTipsInteractor()
        let router = CBTipsRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToTipDetail(_ tip: CBPlantTip, from view: CBTipsViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }

        let tipDetailVC = CBTipDetailRouter.createModule(tip: tip)
        viewController.navigationController?.pushViewController(tipDetailVC, animated: true)
    }
}
