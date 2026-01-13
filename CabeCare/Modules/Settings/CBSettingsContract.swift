//
//  SettingsContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  VIPER Contract for Settings Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol CBSettingsViewProtocol: AnyObject {
    var presenter: CBSettingsPresenterProtocol? { get set }

    func showLanguageOptions(_ languages: [LanguageEntity])
    func updateSelectedLanguage(_ language: LanguageEntity)
}

// MARK: - Presenter Protocol
protocol CBSettingsPresenterProtocol: AnyObject {
    var view: CBSettingsViewProtocol? { get set }
    var interactor: CBSettingsInteractorProtocol? { get set }
    var router: CBSettingsRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectLanguage(_ language: LanguageEntity)
}

// MARK: - Interactor Protocol
protocol CBSettingsInteractorProtocol: AnyObject {
    var presenter: CBSettingsInteractorOutputProtocol? { get set }

    func fetchAvailableLanguages()
    func getCurrentLanguage() -> LanguageEntity
    func saveLanguage(_ language: LanguageEntity)
}

// MARK: - Interactor Output Protocol
protocol CBSettingsInteractorOutputProtocol: AnyObject {
    func didFetchLanguages(_ languages: [LanguageEntity])
    func didSaveLanguage(_ language: LanguageEntity)
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol CBSettingsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// MARK: - Entity
struct LanguageEntity {
    let code: String
    let name: String
    let nativeName: String

    var isSelected: Bool = false
}
