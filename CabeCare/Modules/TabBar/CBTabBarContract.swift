//
//  TabBarContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for TabBar Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol CBTabBarViewProtocol: AnyObject {
    var presenter: CBTabBarPresenterProtocol? { get set }

    func setupTabBar(with viewControllers: [UIViewController], tabItems: [CBTabBarEntity])
    func selectTab(at index: Int)
}

// MARK: - Presenter Protocol
protocol CBTabBarPresenterProtocol: AnyObject {
    var view: CBTabBarViewProtocol? { get set }
    var interactor: CBTabBarInteractorProtocol? { get set }
    var router: CBTabBarRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectTab(at index: Int)
}

// MARK: - Interactor Protocol
protocol CBTabBarInteractorProtocol: AnyObject {
    var presenter: CBTabBarInteractorOutputProtocol? { get set }

    func fetchTabConfiguration()
}

// MARK: - Interactor Output Protocol
protocol CBTabBarInteractorOutputProtocol: AnyObject {
    func didFetchTabConfiguration(_ tabs: [CBTabBarEntity])
}

// MARK: - Router Protocol
protocol CBTabBarRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// MARK: - Entity
struct CBTabBarEntity {
    let icon: String
    let title: String
}
