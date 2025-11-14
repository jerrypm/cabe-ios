//
//  TabBarPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  TabBar Presenter
//

import Foundation

class TabBarPresenter {

    // MARK: - Properties
    weak var view: TabBarViewProtocol?
    var interactor: TabBarInteractorProtocol?
    var router: TabBarRouterProtocol?
}

// MARK: - TabBarPresenterProtocol

extension TabBarPresenter: TabBarPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchTabConfiguration()
    }

    func didSelectTab(at index: Int) {
        view?.selectTab(at: index)
    }
}

// MARK: - TabBarInteractorOutputProtocol

extension TabBarPresenter: TabBarInteractorOutputProtocol {

    func didFetchTabConfiguration(_ tabs: [CBTabBarEntity]) {
        // This will be called by router after setting up view controllers
    }
}
