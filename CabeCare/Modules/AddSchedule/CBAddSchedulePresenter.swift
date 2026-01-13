//
//  AddSchedulePresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Presenter for AddSchedule Module
//

import Foundation

class CBAddSchedulePresenter: CBAddSchedulePresenterProtocol {
    weak var view: CBAddScheduleViewProtocol?
    var interactor: CBAddScheduleInteractorProtocol?
    var router: CBAddScheduleRouterProtocol?

    weak var delegate: CBAddScheduleDelegate?

    func viewDidLoad() {
        if let schedule = interactor?.getScheduleToEdit() {
            view?.showScheduleData(
                plantName: schedule.plantName,
                time: schedule.wateringTime,
                interval: schedule.repeatInterval,
                notes: schedule.notes
            )
        }
    }

    func didTapCancel() {
        router?.dismissModule(from: view)
    }

    func didTapSave(plantName: String?, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?) {
        guard let plantName = plantName, !plantName.isEmpty else {
            view?.showValidationError(message: CommonLK.plantNameTitle.localized)
            return
        }

        if interactor?.getScheduleToEdit() != nil {
            interactor?.updateSchedule(plantName: plantName, time: time, interval: interval, notes: notes)
        } else {
            interactor?.saveSchedule(plantName: plantName, time: time, interval: interval, notes: notes)
        }
    }
}

// MARK: - Interactor Output
extension CBAddSchedulePresenter: CBAddScheduleInteractorOutputProtocol {
    func didSaveSchedule(_ schedule: CBWateringSchedule) {
        delegate?.didAddSchedule(schedule)
        view?.dismissView()
    }

    func didUpdateSchedule(_ schedule: CBWateringSchedule) {
        delegate?.didUpdateSchedule(schedule)
        view?.dismissView()
    }

    func didFailValidation(message: String) {
        view?.showValidationError(message: message)
    }
}
