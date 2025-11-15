//
//  ScheduleConstants.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Schedule Constants

/// Technical constants for the Schedule module
/// Contains non-localizable values like cell identifiers, configuration, icons, etc.
struct ScheduleConstants {

    // MARK: Cell Identifiers
    enum CellIdentifier: String {
        case scheduleCell = "CBScheduleCell"

        var value: String { return rawValue }
    }

    // MARK: Configuration
    enum Config {
        static let maxSchedules = 50
        static let refreshInterval: TimeInterval = 60.0
        static let defaultWateringFrequency = 7 // days
    }

    // MARK: Icons
    enum Icon: String {
        case waterDrop = "drop.fill"
        case calendar = "calendar"
        case clock = "clock.fill"
        case add = "plus.circle.fill"
        case edit = "pencil.circle"
        case delete = "trash.circle"

        var value: String { return rawValue }
    }

    // MARK: Date Formatters
    enum DateFormat: String {
        case time = "HH:mm"
        case date = "dd MMM yyyy"
        case full = "dd MMM yyyy, HH:mm"
        case dayOfWeek = "EEEE"

        var value: String { return rawValue }
    }

    // MARK: Segue Identifiers
    enum Segue: String {
        case showAddSchedule = "ShowAddSchedule"
        case showScheduleDetail = "ShowScheduleDetail"

        var value: String { return rawValue }
    }
}
