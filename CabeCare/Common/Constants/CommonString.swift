//
//  CommonString.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Common Localized Strings (UI)

/// Common UI strings shared across the entire application
/// These include buttons, alerts, messages, and other reusable text elements
public enum CommonLocalization: String {

    // MARK: Buttons
    case okButton = "commonOkButtonLabel"
    case cancelButton = "commonCancelButtonLabel"
    case closeButton = "commonCloseButtonLabel"
    case backButton = "commonBackButtonLabel"
    case saveButton = "commonSaveButtonLabel"
    case deleteButton = "commonDeleteButtonLabel"
    case shareButton = "commonShareButtonLabel"
    case editButton = "commonEditButtonLabel"
    case addButton = "commonAddButtonLabel"

    // MARK: Alerts
    case successTitle = "commonSuccessAlertTitleLabel"
    case errorTitle = "commonErrorAlertTitleLabel"
    case warningTitle = "commonWarningAlertTitleLabel"
    case confirmationTitle = "commonConfirmationAlertTitleLabel"
    case plantNameTitle = "commonPlantNameMessageLabel"

    // MARK: Messages
    case deleteConfirmationMessage = "commonDeleteConfirmationMessageLabel"
    case saveSuccessMessage = "commonSaveSuccessMessageLabel"
    case deleteSuccessMessage = "commonDeleteSuccessMessageLabel"
    case errorMessage = "commonErrorMessageLabel"

    // MARK: General
    case loading = "commonLoadingLabel"
    case noData = "commonNoDataLabel"
    case retry = "commonRetryLabel"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Common Images/Icons

/// Common icon and image asset names
public enum CommonImage: String {
    case appLogo = "app-logo"
    case backArrow = "arrow-back"
    case closeIcon = "close-icon"
    case shareIcon = "share-icon"
    case editIcon = "pencil"
    case deleteIcon = "trash"
    case addIcon = "plus"
    case searchIcon = "magnifyingglass"
    case waterDrop = "drop.fill"
    case calendar = "calendar"
    case clock = "clock.fill"
    case lightbulb = "lightbulb.fill"

    var value: String { return rawValue }
}

// MARK: - Common Constants (Technical)

/// Technical constants used throughout the application
public enum CommonString {
    public static let maxInputLength = 100
    public static let minInputLength = 3
    public static let defaultTimeout: TimeInterval = 30.0
}

// MARK: - UserDefaults Keys

/// Keys for UserDefaults storage
public enum UserDefaultsKey: String {
    case schedules = "cb_schedules_key"
    case tips = "cb_tips_key"
    case hasSeenOnboarding = "cb_has_seen_onboarding"
    case selectedLanguage = "cb_selected_language"

    var value: String { return rawValue }
}

// MARK: - Typealias

/// Shorthand typealias for CommonLocalization
/// Usage: CommonLK.okButton.localized instead of CommonLocalization.okButton.localized
public typealias CommonLK = CommonLocalization
