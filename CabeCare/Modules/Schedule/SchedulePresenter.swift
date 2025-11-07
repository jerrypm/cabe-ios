//
//  SchedulePresenter.swift
//  CabeCare
//
//  VIPER Presenter for Schedule Module
//

import Foundation

class SchedulePresenter: SchedulePresenterProtocol {
    weak var view: ScheduleViewProtocol?
    var interactor: ScheduleInteractorProtocol?
    var router: ScheduleRouterProtocol?

    private var schedules: [WateringSchedule] = []

    func viewDidLoad() {
        interactor?.fetchSchedules()
    }

    func viewWillAppear() {
        interactor?.fetchSchedules()
    }

    func didTapAddSchedule() {
        router?.navigateToAddSchedule(from: view)
    }

    func didSelectSchedule(_ schedule: WateringSchedule) {
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
extension SchedulePresenter: ScheduleInteractorOutputProtocol {
    func didFetchSchedules(_ schedules: [WateringSchedule]) {
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
