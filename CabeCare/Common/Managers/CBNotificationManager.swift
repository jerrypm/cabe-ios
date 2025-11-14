//
//  CBNotificationManager.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Manages local notifications for watering reminders
//

import Foundation
import UserNotifications

class CBNotificationManager {
    static let shared = CBNotificationManager()

    private init() {}

    // Schedule notification for watering reminder
    func scheduleWateringNotification(for schedule: CBWateringSchedule) {
        guard schedule.isEnabled else { return }

        let content = UNMutableNotificationContent()
        content.title = "🌶️ Waktunya Menyiram Cabe!"
        content.body = "Jangan lupa menyiram tanaman \(schedule.plantName) Anda"
        content.sound = .default
        content.badge = 1

        if let notes = schedule.notes, !notes.isEmpty {
            content.subtitle = notes
        }

        // Calculate trigger time
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: schedule.wateringTime)

        let trigger: UNNotificationTrigger

        switch schedule.repeatInterval {
        case .daily, .everyTwoDays, .everyThreeDays, .weekly:
            // For daily and multi-day intervals, use calendar trigger
            var dateComponents = DateComponents()
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute

            // For non-daily intervals, we'll use time interval trigger
            if schedule.repeatInterval == .daily {
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            } else {
                let interval = schedule.repeatInterval.timeInterval
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
            }

        case .twiceDaily:
            // For twice daily, schedule at specific time
            var dateComponents = DateComponents()
            dateComponents.hour = components.hour
            dateComponents.minute = components.minute
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        }

        let identifier = "watering-\(schedule.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully for \(schedule.plantName)")
            }
        }

        // For twice daily, schedule second notification
        if schedule.repeatInterval == .twiceDaily {
            scheduleTwiceDailySecondNotification(for: schedule, components: components)
        }
    }

    private func scheduleTwiceDailySecondNotification(for schedule: CBWateringSchedule, components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "🌶️ Waktunya Menyiram Cabe!"
        content.body = "Jangan lupa menyiram tanaman \(schedule.plantName) Anda (penyiraman ke-2)"
        content.sound = .default
        content.badge = 1

        var secondComponents = DateComponents()
        // Add 12 hours to the original time
        if let hour = components.hour {
            secondComponents.hour = (hour + 12) % 24
        }
        secondComponents.minute = components.minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: secondComponents, repeats: true)
        let identifier = "watering-twice-\(schedule.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling second notification: \(error.localizedDescription)")
            }
        }
    }

    // Cancel notification for a schedule
    func cancelWateringNotification(for schedule: CBWateringSchedule) {
        let identifier = "watering-\(schedule.id.uuidString)"
        let secondIdentifier = "watering-twice-\(schedule.id.uuidString)"

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier, secondIdentifier])
        print("Notification canceled for \(schedule.plantName)")
    }

    // Send immediate notification for tips
    func sendTipNotification(tip: CBPlantTip) {
        let content = UNMutableNotificationContent()
        content.title = "💡 Tips Perawatan Cabe"
        content.body = tip.title
        content.sound = .default
        content.badge = 1

        // Show notification immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = "tip-\(tip.id.uuidString)"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending tip notification: \(error.localizedDescription)")
            } else {
                print("Tip notification sent successfully")
            }
        }
    }

    // Clear all notifications
    func clearAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
