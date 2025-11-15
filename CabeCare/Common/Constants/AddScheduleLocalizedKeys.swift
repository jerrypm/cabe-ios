//
//  AddScheduleLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Add Schedule Localized Keys

/// Localized strings for the AddSchedule module
/// Contains form labels, placeholders, and success messages
enum AddScheduleLocalizedKey: String {

    // MARK: Navigation
    case screenTitleAdd = "addScheduleScreenTitleLabel"
    case screenTitleEdit = "addScheduleEditScreenTitleLabel"

    // MARK: Labels
    case plantNameLabel = "addSchedulePlantNameLabel"
    case wateringTimeLabel = "addScheduleWateringTimeLabel"
    case frequencyLabel = "addScheduleFrequencyLabel"
    case intervalLabel = "addScheduleIntervalLabel"
    case notesLabel = "addScheduleNotesLabel"

    // MARK: Placeholders
    case plantNamePlaceholder = "addSchedulePlantNamePlaceholderTextField"
    case notesPlaceholder = "addScheduleNotesPlaceholderTextField"

    // MARK: Buttons
    case saveButton = "addScheduleSaveButtonLabel"

    // MARK: Alerts
    case saveSuccessMessage = "addScheduleSaveSuccessMessageLabel"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Typealias

/// Shorthand typealias for AddScheduleLocalizedKey
/// Usage: AddScheduleLK.screenTitle.localized
typealias AddScheduleLK = AddScheduleLocalizedKey
