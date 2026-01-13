//
//  TipDetailPresenter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Presenter for TipDetail Module
//

import Foundation

class CBTipDetailPresenter: CBTipDetailPresenterProtocol {
    weak var view: CBTipDetailViewProtocol?
    var interactor: CBTipDetailInteractorProtocol?
    var router: CBTipDetailRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchTipDetail()
    }

    func didTapShare() {
        guard let text = interactor?.getShareText() else { return }
        router?.presentShareSheet(with: text, from: view, sourceView: nil)
    }
}

// MARK: - Interactor Output
extension CBTipDetailPresenter: CBTipDetailInteractorOutputProtocol {
    func didFetchTipDetail(title: String, content: String, source: String?) {
        view?.showTipDetail(title: title, content: content, source: source)
    }
}
