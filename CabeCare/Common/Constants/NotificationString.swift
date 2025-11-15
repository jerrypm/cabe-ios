//
//  NotificationString.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Notification Localized Keys

/// Notification text constants for push notifications and local notifications
/// Includes support for variable interpolation in notification bodies
public enum NotificationLocalizedKey: String {

    // MARK: Watering Reminder
    case wateringReminderTitle = "notificationWateringReminderTitleLabel"
    case wateringReminderBody = "notificationWateringReminderBodyLabel"

    // MARK: Tip of the Day
    case tipOfTheDayTitle = "notificationTipOfTheDayTitleLabel"

    // MARK: Schedule Alert
    case scheduleAlertTitle = "notificationScheduleAlertTitleLabel"
    case scheduleAlertBody = "notificationScheduleAlertBodyLabel"

    var localized: String {
        return rawValue.localize()
    }

    /// Localize with variable interpolation
    /// Use this for notification bodies that contain dynamic content
    ///
    /// Example:
    /// ```
    /// NotificationLK.wateringReminderBody.localized(with: ["plantName": "Cabai Merah"])
    /// ```
    ///
    /// - Parameter variables: Dictionary of key-value pairs for interpolation
    /// - Returns: Localized string with variables replaced
    func localized(with variables: [String: String]) -> String {
        return rawValue.localize(with: variables)
    }
}

// MARK: - Typealias

/// Shorthand typealias for NotificationLocalizedKey
/// Usage: NotificationLK.wateringReminderTitle.localized
public typealias NotificationLK = NotificationLocalizedKey
