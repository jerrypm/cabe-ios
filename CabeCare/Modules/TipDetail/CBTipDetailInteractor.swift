//
//  TipDetailInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Interactor for TipDetail Module
//

import Foundation

class CBTipDetailInteractor: CBTipDetailInteractorProtocol {
    weak var presenter: CBTipDetailInteractorOutputProtocol?
    var tip: CBPlantTip?

    func fetchTipDetail() {
        guard let tip = tip else { return }

        presenter?.didFetchTipDetail(
            title: tip.title,
            content: tip.content,
            source: tip.source
        )
    }

    func getShareText() -> String {
        guard let tip = tip else { return "" }

        let sourceText = tip.source.map {
            TipDetailLK.sourceLabel.localized(with: ["source": $0])
        } ?? ""

        return TipDetailLK.shareTextTemplate.localized(with: [
            "title": tip.title,
            "content": tip.content,
            "source": sourceText
        ])
    }
}
