//
//  ScheduleLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Schedule Localized Keys

/// Localized strings for the Schedule module
/// Contains all user-facing text for the Schedule screen
enum ScheduleLocalizedKey: String {

    // MARK: Navigation
    case screenTitle = "scheduleScreenTitleLabel"

    // MARK: Buttons
    case addScheduleButton = "scheduleAddScheduleButtonLabel"

    // MARK: Labels
    case nextWateringLabel = "scheduleNextWateringLabel"

    // MARK: Empty State
    case emptyStateMessage = "scheduleEmptyStateMessageLabel"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Typealias

/// Shorthand typealias for ScheduleLocalizedKey
/// Usage: ScheduleLK.screenTitle.localized
typealias ScheduleLK = ScheduleLocalizedKey
