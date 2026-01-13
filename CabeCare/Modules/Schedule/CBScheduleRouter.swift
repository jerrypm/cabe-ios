//
//  CBScheduleRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Router for Schedule Module
//

import UIKit

class CBScheduleRouter: CBScheduleRouterProtocol {

    static func createModule() -> UIViewController {
        let view = CBScheduleView()
        let presenter = CBSchedulePresenter()
        let interactor = CBScheduleInteractor()
        let router = CBScheduleRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToAddSchedule(from view: CBScheduleViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }

        let addScheduleVC = CBAddScheduleRouter.createModule(schedule: nil as CBWateringSchedule?, delegate: viewController as? CBAddScheduleDelegate)
        let navController = UINavigationController(rootViewController: addScheduleVC)

        viewController.present(navController, animated: true)
    }

    func navigateToEditSchedule(_ schedule: CBWateringSchedule, from view: CBScheduleViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }

        let addScheduleVC = CBAddScheduleRouter.createModule(schedule: schedule, delegate: viewController as? CBAddScheduleDelegate)
        let navController = UINavigationController(rootViewController: addScheduleVC)

        viewController.present(navController, animated: true)
    }
}

// MARK: - CBAddScheduleDelegate Extension
extension CBScheduleView: CBAddScheduleDelegate {
    func didAddSchedule(_ schedule: CBWateringSchedule) {
        presenter?.viewWillAppear()
    }

    func didUpdateSchedule(_ schedule: CBWateringSchedule) {
        presenter?.viewWillAppear()
    }
}
