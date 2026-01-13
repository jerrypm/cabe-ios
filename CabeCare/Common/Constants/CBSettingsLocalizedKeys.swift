//
//  SettingsLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-23.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Settings Localized Keys

/// Localized strings for the Settings module
/// Contains all UI text and labels
enum SettingsLocalizedKey: String {

    // MARK: Screen Titles
    case screenTitle = "settingsScreenTitle"

    // MARK: Language Section
    case languageSectionTitle = "settingsLanguageSectionTitle"

    // MARK: Restart Alert
    case restartAlertTitle = "settingsRestartAlertTitle"
    case restartAlertMessage = "settingsRestartAlertMessage"
    case restartAlertOK = "settingsRestartAlertOK"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Typealias

/// Shorthand typealias for SettingsLocalizedKey
/// Usage: SettingsLK.screenTitle.localized
typealias SettingsLK = SettingsLocalizedKey
