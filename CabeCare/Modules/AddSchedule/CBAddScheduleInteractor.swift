//
//  AddScheduleInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Interactor for AddSchedule Module
//

import Foundation

class CBAddScheduleInteractor: CBAddScheduleInteractorProtocol {
    weak var presenter: CBAddScheduleInteractorOutputProtocol?
    var scheduleToEdit: CBWateringSchedule?

    private let dataManager = CBDataManager.shared
    private let notificationManager = CBNotificationManager.shared

    func getScheduleToEdit() -> CBWateringSchedule? {
        return scheduleToEdit
    }

    func saveSchedule(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?) {
        let schedule = CBWateringSchedule(
            plantName: plantName,
            wateringTime: time,
            repeatInterval: interval,
            notes: notes
        )

        // Schedule notifications
        notificationManager.scheduleWateringNotification(for: schedule)

        // Save to storage
        dataManager.addSchedule(schedule)

        presenter?.didSaveSchedule(schedule)
    }

    func updateSchedule(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?) {
        guard var existingSchedule = scheduleToEdit else { return }

        // Cancel old notifications
        notificationManager.cancelWateringNotification(for: existingSchedule)

        // Update schedule data
        existingSchedule.plantName = plantName
        existingSchedule.wateringTime = time
        existingSchedule.repeatInterval = interval
        existingSchedule.notes = notes

        // Schedule new notifications
        notificationManager.scheduleWateringNotification(for: existingSchedule)

        // Save to storage
        dataManager.updateSchedule(existingSchedule)

        presenter?.didUpdateSchedule(existingSchedule)
    }
}
