//
//  TabBarLocalizedKeys.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

// MARK: - TabBar Localized Keys

/// Localized strings for the TabBar module
/// Contains tab titles and related UI text
enum TabBarLocalizedKey: String {

    // MARK: Tab Titles
    case scheduleTab = "tabBarScheduleTabLabel"
    case tipsTab = "tabBarTipsTabLabel"

    var localized: String {
        return rawValue.localize()
    }
}

// MARK: - Typealias

/// Shorthand typealias for TabBarLocalizedKey
/// Usage: TabBarLK.scheduleTab.localized
typealias TabBarLK = TabBarLocalizedKey
