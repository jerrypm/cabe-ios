//
//  TipsPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Presenter for Tips Module
//

import Foundation

class CBTipsPresenter: CBTipsPresenterProtocol {
    weak var view: CBTipsViewProtocol?
    var interactor: CBTipsInteractorProtocol?
    var router: CBTipsRouterProtocol?

    private var tips: [CBPlantTip] = []

    func viewDidLoad() {
        interactor?.fetchTips()
    }

    func didSearchTips(with query: String) {
        interactor?.filterTips(with: query)
    }

    func didTapSearchOnline() {
        // View will show alert for query input
    }

    func didSelectTip(_ tip: CBPlantTip) {
        router?.navigateToTipDetail(tip, from: view)
    }

    func performOnlineSearch(query: String) {
        view?.showLoading()
        interactor?.searchOnlineTips(query: query)
    }
}

// MARK: - Interactor Output
extension CBTipsPresenter: CBTipsInteractorOutputProtocol {
    func didFetchTips(_ tips: [CBPlantTip]) {
        self.tips = tips

        if tips.isEmpty {
            view?.showEmptyState()
        } else {
            view?.hideEmptyState()
            view?.showTips(tips)
        }
    }

    func didFilterTips(_ tips: [CBPlantTip]) {
        self.tips = tips
        view?.showTips(tips)
    }

    func didFindOnlineTips(_ tips: [CBPlantTip]) {
        view?.hideLoading()

        if tips.isEmpty {
            view?.showAlert(
                title: TipsAlertLK.notFoundTitle.localized,
                message: TipsAlertLK.notFoundMessage.localized
            )
        } else {
            // Save first tip
            let firstTip = tips[0]
            interactor?.saveTip(firstTip)
        }
    }

    func didSaveTip(_ tip: CBPlantTip) {
        // Reload tips after saving
        interactor?.fetchTips()

        view?.showAlert(
            title: TipsAlertLK.tipAddedSuccessMessage.localized,
            message: TipsAlertLK.tipAddedWithNotificationMessage.localized
        )
    }

    func didFailWithError(_ error: Error) {
        view?.hideLoading()
        view?.showAlert(title: CommonLK.warningTitle.localized, message: error.localizedDescription)
    }
}
