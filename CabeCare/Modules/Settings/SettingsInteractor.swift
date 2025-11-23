//
//  SettingsInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  Settings Interactor
//

import Foundation

class SettingsInteractor {

    // MARK: - Properties
    weak var presenter: SettingsInteractorOutputProtocol?

    private let userDefaults = UserDefaults.standard
    private let languageKey = "AppLanguage"
}

// MARK: - SettingsInteractorProtocol

extension SettingsInteractor: SettingsInteractorProtocol {

    func fetchAvailableLanguages() {
        let currentLanguageCode = getCurrentLanguageCode()

        let languages = [
            LanguageEntity(code: "en", name: "English", nativeName: "English", isSelected: currentLanguageCode == "en"),
            LanguageEntity(code: "id", name: "Indonesian", nativeName: "Bahasa Indonesia", isSelected: currentLanguageCode == "id")
        ]

        presenter?.didFetchLanguages(languages)
    }

    func getCurrentLanguage() -> LanguageEntity {
        let currentLanguageCode = getCurrentLanguageCode()

        switch currentLanguageCode {
        case "id":
            return LanguageEntity(code: "id", name: "Indonesian", nativeName: "Bahasa Indonesia", isSelected: true)
        default:
            return LanguageEntity(code: "en", name: "English", nativeName: "English", isSelected: true)
        }
    }

    func saveLanguage(_ language: LanguageEntity) {
        userDefaults.set(language.code, forKey: languageKey)
        userDefaults.synchronize()

        // Update app language
        UserDefaults.standard.set([language.code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        presenter?.didSaveLanguage(language)
    }

    // MARK: - Private Methods

    private func getCurrentLanguageCode() -> String {
        if let savedLanguage = userDefaults.string(forKey: languageKey) {
            return savedLanguage
        }

        // Default to system language or English
        let preferredLanguage = Locale.preferredLanguages.first ?? "en"
        if preferredLanguage.hasPrefix("id") {
            return "id"
        }
        return "en"
    }
}
