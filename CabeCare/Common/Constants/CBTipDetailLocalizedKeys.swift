//
//  TipDetailLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Tip Detail Localized Keys

/// Localized strings for the TipDetail module
/// Contains navigation and action button text
enum TipDetailLocalizedKey: String {

    // MARK: Navigation
    case screenTitle = "tipDetailScreenTitleLabel"

    // MARK: Buttons
    case editButton = "tipDetailEditButtonLabel"
    case deleteButton = "tipDetailDeleteButtonLabel"
    case shareButton = "tipDetailShareButtonLabel"

    // MARK: Labels
    case sourceLabel = "tipDetailSourceLabel"
    case shareTextTemplate = "tipDetailShareTextTemplate"

    var localized: String {
        return rawValue.localize()
    }

    func localized(with variables: [String: String]) -> String {
        return rawValue.localize(with: variables)
    }
}

// MARK: - Typealias

/// Shorthand typealias for TipDetailLocalizedKey
/// Usage: TipDetailLK.screenTitle.localized
typealias TipDetailLK = TipDetailLocalizedKey
