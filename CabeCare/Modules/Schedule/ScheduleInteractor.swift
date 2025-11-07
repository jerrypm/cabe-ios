//
//  ScheduleInteractor.swift
//  CabeCare
//
//  VIPER Interactor for Schedule Module
//

import Foundation

class ScheduleInteractor: ScheduleInteractorProtocol {
    weak var presenter: ScheduleInteractorOutputProtocol?

    private let dataManager = DataManager.shared
    private let notificationManager = NotificationManager.shared

    func fetchSchedules() {
        let schedules = dataManager.loadSchedules()
        presenter?.didFetchSchedules(schedules)
    }

    func toggleSchedule(_ schedule: WateringSchedule, isEnabled: Bool) {
        var updatedSchedule = schedule
        updatedSchedule.isEnabled = isEnabled

        if isEnabled {
            notificationManager.scheduleWateringNotification(for: updatedSchedule)
        } else {
            notificationManager.cancelWateringNotification(for: updatedSchedule)
        }

        dataManager.updateSchedule(updatedSchedule)
        presenter?.didUpdateSchedule()
    }

    func deleteSchedule(_ schedule: WateringSchedule) {
        notificationManager.cancelWateringNotification(for: schedule)
        dataManager.deleteSchedule(schedule)
        presenter?.didDeleteSchedule()
    }
}
