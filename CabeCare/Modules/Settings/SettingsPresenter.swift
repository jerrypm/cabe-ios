//
//  SettingsPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  Settings Presenter
//

import Foundation

class SettingsPresenter {

    // MARK: - Properties
    weak var view: SettingsViewProtocol?
    var interactor: SettingsInteractorProtocol?
    var router: SettingsRouterProtocol?
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchAvailableLanguages()
    }

    func didSelectLanguage(_ language: LanguageEntity) {
        interactor?.saveLanguage(language)
    }
}

// MARK: - SettingsInteractorOutputProtocol

extension SettingsPresenter: SettingsInteractorOutputProtocol {

    func didFetchLanguages(_ languages: [LanguageEntity]) {
        view?.showLanguageOptions(languages)
    }

    func didSaveLanguage(_ language: LanguageEntity) {
        view?.updateSelectedLanguage(language)
    }

    func didFailWithError(_ error: Error) {
        // Handle error if needed
        print("Settings Error: \(error.localizedDescription)")
    }
}
