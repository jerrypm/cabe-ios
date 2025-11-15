//
//  String+Localization.swift
//  CabeCare
//
//  Created on 2025-01-14.
//  Pattern: Mandiri iOS String Management
//

import Foundation

extension String {
    /// Localize the string using NSLocalizedString
    /// Returns the localized string from Localizable.strings
    ///
    /// Example:
    /// ```
    /// "scheduleScreenTitleLabel".localize()
    /// ```
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }

    /// Localize the string with variable interpolation
    /// Variables in the format {{key}} will be replaced with values from the dictionary
    ///
    /// Example:
    /// ```
    /// "Hello {{name}}!".localize(with: ["name": "John"])
    /// // Returns: "Hello John!"
    /// ```
    ///
    /// - Parameter variables: Dictionary of key-value pairs for interpolation
    /// - Returns: Localized string with variables replaced
    func localize(with variables: [String: String]) -> String {
        var result = self.localize()
        for (key, value) in variables {
            result = result.replacingOccurrences(of: "{{\(key)}}", with: value)
        }
        return result
    }
}
