//
//  ScheduleInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Interactor for Schedule Module
//

import Foundation

class ScheduleInteractor: ScheduleInteractorProtocol {
    weak var presenter: ScheduleInteractorOutputProtocol?

    private let dataManager = CBDataManager.shared
    private let notificationManager = CBNotificationManager.shared

    func fetchSchedules() {
        let schedules = dataManager.loadSchedules()
        presenter?.didFetchSchedules(schedules)
    }

    func toggleSchedule(_ schedule: CBWateringSchedule, isEnabled: Bool) {
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

    func deleteSchedule(_ schedule: CBWateringSchedule) {
        notificationManager.cancelWateringNotification(for: schedule)
        dataManager.deleteSchedule(schedule)
        presenter?.didDeleteSchedule()
    }
}
