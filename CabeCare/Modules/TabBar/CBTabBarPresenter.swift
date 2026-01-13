//
//  TabBarPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  TabBar Presenter
//

import Foundation

class CBTabBarPresenter {

    // MARK: - Properties
    weak var view: CBTabBarViewProtocol?
    var interactor: CBTabBarInteractorProtocol?
    var router: CBTabBarRouterProtocol?
}

// MARK: - CBTabBarPresenterProtocol

extension CBTabBarPresenter: CBTabBarPresenterProtocol {

    func viewDidLoad() {
        interactor?.fetchTabConfiguration()
    }

    func didSelectTab(at index: Int) {
        view?.selectTab(at: index)
    }
}

// MARK: - CBTabBarInteractorOutputProtocol

extension CBTabBarPresenter: CBTabBarInteractorOutputProtocol {

    func didFetchTabConfiguration(_ tabs: [CBTabBarEntity]) {
        // This will be called by router after setting up view controllers
    }
}
