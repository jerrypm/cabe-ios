//
//  CBTipDetailRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Router for TipDetail Module
//

import UIKit

class CBTipDetailRouter: CBTipDetailRouterProtocol {

    static func createModule(tip: CBPlantTip) -> UIViewController {
        let view = CBTipDetailView()
        let presenter = CBTipDetailPresenter()
        let interactor = CBTipDetailInteractor()
        let router = CBTipDetailRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.tip = tip

        return view
    }

    func presentShareSheet(with text: String, from view: CBTipDetailViewProtocol?, sourceView: UIView?) {
        guard let viewController = view as? UIViewController else { return }

        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        if let sourceView = sourceView {
            activityVC.popoverPresentationController?.sourceView = sourceView
        }

        viewController.present(activityVC, animated: true)
    }
}
