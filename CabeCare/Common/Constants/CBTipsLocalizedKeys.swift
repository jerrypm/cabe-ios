//
//  TipsLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Tips Landing Localized Keys

/// Localized strings for the Tips Landing screen
/// Contains navigation, search, and empty state text
enum TipsLandingLocalizedKey: String {

    // MARK: Navigation
    case screenTitle = "tipsLandingScreenTitleLabel"

    // MARK: Buttons
    case addTipButton = "tipsLandingAddTipButtonLabel"
    case searchOnlineButton = "tipsLandingSearchOnlineButtonLabel"

    // MARK: Empty State
    case emptyStateMessage = "tipsLandingEmptyStateMessageLabel"

    // MARK: Search
    case searchPlaceholder = "tipsLandingSearchPlaceholderTextField"
    case searchQueryPlaceholder = "tipsLandingSearchQueryPlaceholderTextField"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Tips Alert Localized Keys

/// Localized strings for Tips alerts (add, edit, delete)
/// Contains all alert titles, messages, and placeholders
enum TipsAlertLocalizedKey: String {

    // MARK: Add Tip Alert
    case addTipAlertTitle = "tipsAddTipAlertTitleLabel"
    case addTipAlertMessage = "tipsAddTipAlertMessageLabel"
    case titlePlaceholder = "tipsAddTipTitlePlaceholderTextField"
    case descriptionPlaceholder = "tipsAddTipDescriptionPlaceholderTextField"

    // MARK: Edit Tip Alert
    case editTipAlertTitle = "tipsEditTipAlertTitleLabel"

    // MARK: Delete Confirmation
    case deleteConfirmationTitle = "tipsDeleteConfirmationTitleLabel"
    case deleteConfirmationMessage = "tipsDeleteConfirmationMessageLabel"

    // MARK: Success Messages
    case tipAddedSuccessMessage = "tipsTipAddedSuccessMessageLabel"
    case tipUpdatedSuccessMessage = "tipsTipUpdatedSuccessMessageLabel"
    case tipDeletedSuccessMessage = "tipsTipDeletedSuccessMessageLabel"
    case tipAddedWithNotificationMessage = "tipsTipAddedWithNotificationMessageLabel"

    // MARK: Search Actions
    case searchButton = "tipsSearchButtonLabel"
    case loadingMessage = "tipsLoadingMessageLabel"
    case notFoundTitle = "tipsNotFoundTitleLabel"
    case notFoundMessage = "tipsNotFoundMessageLabel"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Typealiases

/// Shorthand typealias for TipsLandingLocalizedKey
/// Usage: TipsLandingLK.screenTitle.localized
typealias TipsLandingLK = TipsLandingLocalizedKey

/// Shorthand typealias for TipsAlertLocalizedKey
/// Usage: TipsAlertLK.addTipAlertTitle.localized
typealias TipsAlertLK = TipsAlertLocalizedKey
