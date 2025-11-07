//
//  ScheduleRouter.swift
//  CabeCare
//
//  VIPER Router for Schedule Module
//

import UIKit

class ScheduleRouter: ScheduleRouterProtocol {

    static func createModule() -> UIViewController {
        let view = ScheduleView()
        let presenter = SchedulePresenter()
        let interactor = ScheduleInteractor()
        let router = ScheduleRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToAddSchedule(from view: ScheduleViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }

        let addScheduleVC = AddScheduleRouter.createModule(schedule: nil as WateringSchedule?, delegate: viewController as? AddScheduleDelegate)
        let navController = UINavigationController(rootViewController: addScheduleVC)

        viewController.present(navController, animated: true)
    }

    func navigateToEditSchedule(_ schedule: WateringSchedule, from view: ScheduleViewProtocol?) {
        guard let viewController = view as? UIViewController else { return }

        let addScheduleVC = AddScheduleRouter.createModule(schedule: schedule, delegate: viewController as? AddScheduleDelegate)
        let navController = UINavigationController(rootViewController: addScheduleVC)

        viewController.present(navController, animated: true)
    }
}

// MARK: - AddScheduleDelegate Extension
extension ScheduleView: AddScheduleDelegate {
    func didAddSchedule(_ schedule: WateringSchedule) {
        presenter?.viewWillAppear()
    }

    func didUpdateSchedule(_ schedule: WateringSchedule) {
        presenter?.viewWillAppear()
    }
}
