//
//  TipsConstants.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - Tips Constants

/// Technical constants for the Tips module
/// Contains non-localizable values like cell identifiers, configuration, icons, etc.
struct TipsConstants {

    // MARK: Cell Identifiers
    enum CellIdentifier: String {
        case tipCell = "CBTipCell"

        var value: String { return rawValue }
    }

    // MARK: Configuration
    enum Config {
        static let maxTitleLength = 50
        static let maxDescriptionLength = 200
        static let minTitleLength = 3
        static let searchDebounceInterval: TimeInterval = 0.3
    }

    // MARK: Icons
    enum Icon: String {
        case lightbulb = "lightbulb.fill"
        case edit = "pencil"
        case delete = "trash"
        case search = "magnifyingglass"
        case add = "plus.circle.fill"
        case emptyState = "lightbulb.slash"

        var value: String { return rawValue }
    }

    // MARK: Alert TextField Tags
    enum TextFieldTag: Int {
        case title = 100
        case description = 101
    }

    // MARK: Segue Identifiers
    enum Segue: String {
        case showTipDetail = "ShowTipDetail"

        var value: String { return rawValue }
    }
}
