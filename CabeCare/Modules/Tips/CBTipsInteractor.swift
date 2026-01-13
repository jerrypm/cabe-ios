//
//  TipsInteractor.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Interactor for Tips Module
//

import Foundation

class CBTipsInteractor: CBTipsInteractorProtocol {
    weak var presenter: CBTipsInteractorOutputProtocol?

    private let dataManager = CBDataManager.shared
    private let searchManager = CBTipsSearchManager.shared
    private let notificationManager = CBNotificationManager.shared

    private var allTips: [CBPlantTip] = []

    func fetchTips() {
        // Load predefined tips
        var tips = searchManager.getAllTips()

        // Load saved tips from storage
        let savedTips = dataManager.loadTips()

        // Combine and remove duplicates
        for savedTip in savedTips {
            if !tips.contains(where: { $0.id == savedTip.id }) {
                tips.insert(savedTip, at: 0)
            }
        }

        allTips = tips
        presenter?.didFetchTips(tips)
    }

    func filterTips(with searchText: String) {
        if searchText.isEmpty {
            presenter?.didFilterTips(allTips)
        } else {
            let filtered = allTips.filter { tip in
                tip.title.lowercased().contains(searchText.lowercased()) ||
                tip.content.lowercased().contains(searchText.lowercased())
            }
            presenter?.didFilterTips(filtered)
        }
    }

    func searchOnlineTips(query: String) {
        searchManager.searchTips(query: query) { [weak self] tips in
            guard let self = self else { return }

            if tips.isEmpty {
                self.presenter?.didFindOnlineTips([])
            } else {
                self.presenter?.didFindOnlineTips(tips)
            }
        }
    }

    func saveTip(_ tip: CBPlantTip) {
        dataManager.addTip(tip)
        notificationManager.sendTipNotification(tip: tip)
        presenter?.didSaveTip(tip)
    }
}
