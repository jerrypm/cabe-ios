//
//  CBAddScheduleRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Router for AddSchedule Module
//

import UIKit

class CBAddScheduleRouter: CBAddScheduleRouterProtocol {

    static func createModule(schedule: CBWateringSchedule?, delegate: CBAddScheduleDelegate?) -> UIViewController {
        let view = CBAddScheduleView()
        let presenter = CBAddSchedulePresenter()
        let interactor = CBAddScheduleInteractor()
        let router = CBAddScheduleRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.delegate = delegate
        interactor.presenter = presenter
        interactor.scheduleToEdit = schedule

        return view
    }

    func dismissModule(from view: CBAddScheduleViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }
        viewController.dismiss(animated: true)
    }
}
