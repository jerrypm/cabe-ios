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
protocol SettingsViewProtocol: AnyObject {
    var presenter: SettingsPresenterProtocol? { get set }

    func showLanguageOptions(_ languages: [LanguageEntity])
    func updateSelectedLanguage(_ language: LanguageEntity)
}

// MARK: - Presenter Protocol
protocol SettingsPresenterProtocol: AnyObject {
    var view: SettingsViewProtocol? { get set }
    var interactor: SettingsInteractorProtocol? { get set }
    var router: SettingsRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectLanguage(_ language: LanguageEntity)
}

// MARK: - Interactor Protocol
protocol SettingsInteractorProtocol: AnyObject {
    var presenter: SettingsInteractorOutputProtocol? { get set }

    func fetchAvailableLanguages()
    func getCurrentLanguage() -> LanguageEntity
    func saveLanguage(_ language: LanguageEntity)
}

// MARK: - Interactor Output Protocol
protocol SettingsInteractorOutputProtocol: AnyObject {
    func didFetchLanguages(_ languages: [LanguageEntity])
    func didSaveLanguage(_ language: LanguageEntity)
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol SettingsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// MARK: - Entity
struct LanguageEntity {
    let code: String
    let name: String
    let nativeName: String

    var isSelected: Bool = false
}
