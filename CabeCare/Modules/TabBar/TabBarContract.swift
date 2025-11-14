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
protocol TabBarViewProtocol: AnyObject {
    var presenter: TabBarPresenterProtocol? { get set }

    func setupTabBar(with viewControllers: [UIViewController], tabItems: [CBTabBarEntity])
    func selectTab(at index: Int)
}

// MARK: - Presenter Protocol
protocol TabBarPresenterProtocol: AnyObject {
    var view: TabBarViewProtocol? { get set }
    var interactor: TabBarInteractorProtocol? { get set }
    var router: TabBarRouterProtocol? { get set }

    func viewDidLoad()
    func didSelectTab(at index: Int)
}

// MARK: - Interactor Protocol
protocol TabBarInteractorProtocol: AnyObject {
    var presenter: TabBarInteractorOutputProtocol? { get set }

    func fetchTabConfiguration()
}

// MARK: - Interactor Output Protocol
protocol TabBarInteractorOutputProtocol: AnyObject {
    func didFetchTabConfiguration(_ tabs: [CBTabBarEntity])
}

// MARK: - Router Protocol
protocol TabBarRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

// MARK: - Entity
struct CBTabBarEntity {
    let icon: String
    let title: String
}
