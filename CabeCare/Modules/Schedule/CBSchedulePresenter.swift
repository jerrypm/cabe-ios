//
//  SchedulePresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Presenter for Schedule Module
//

import Foundation

class CBSchedulePresenter: CBSchedulePresenterProtocol {
    weak var view: CBScheduleViewProtocol?
    var interactor: CBScheduleInteractorProtocol?
    var router: CBScheduleRouterProtocol?

    private var schedules: [CBWateringSchedule] = []

    func viewDidLoad() {
        interactor?.fetchSchedules()
    }

    func viewWillAppear() {
        interactor?.fetchSchedules()
    }

    func didTapAddSchedule() {
        router?.navigateToAddSchedule(from: view)
    }

    func didSelectSchedule(_ schedule: CBWateringSchedule) {
        router?.navigateToEditSchedule(schedule, from: view)
    }

    func didToggleSchedule(at index: Int, isEnabled: Bool) {
        guard index < schedules.count else { return }
        var schedule = schedules[index]
        interactor?.toggleSchedule(schedule, isEnabled: isEnabled)
    }

    func didDeleteSchedule(at index: Int) {
        guard index < schedules.count else { return }
        let schedule = schedules[index]
        interactor?.deleteSchedule(schedule)
    }
}

// MARK: - Interactor Output
extension CBSchedulePresenter: CBScheduleInteractorOutputProtocol {
    func didFetchSchedules(_ schedules: [CBWateringSchedule]) {
        self.schedules = schedules

        if schedules.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
            view?.showSchedules(schedules)
        }
    }

    func didUpdateSchedule() {
        interactor?.fetchSchedules()
    }

    func didDeleteSchedule() {
        interactor?.fetchSchedules()
    }

    func didFailWithError(_ error: Error) {
        // Handle error
        print("Error: \(error.localizedDescription)")
    }
}
