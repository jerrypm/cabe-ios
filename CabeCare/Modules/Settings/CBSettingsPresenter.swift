//
//  SettingsPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  Settings Presenter
//

import Foundation

class CBSettingsPresenter {

    // MARK: - Properties
    weak var view: CBSettingsViewProtocol?
    var interactor: CBSettingsInteractorProtocol?
    var router: CBSettingsRouterProtocol?
}

// MARK: - CBSettingsPresenterProtocol

extension CBSettingsPresenter: CBSettingsPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchAvailableLanguages()
    }

    func didSelectLanguage(_ language: LanguageEntity) {
        interactor?.saveLanguage(language)
    }
}

// MARK: - CBSettingsInteractorOutputProtocol

extension CBSettingsPresenter: CBSettingsInteractorOutputProtocol {

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
