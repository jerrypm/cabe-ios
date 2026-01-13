//
//  TipsContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for Tips Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol CBTipsViewProtocol: AnyObject {
    var presenter: CBTipsPresenterProtocol? { get set }

    func showTips(_ tips: [CBPlantTip])
    func showEmptyState()
    func hideEmptyState()
    func showLoading()
    func hideLoading()
    func showAlert(title: String, message: String)
    func reloadData()
}

// MARK: - Presenter Protocol
protocol CBTipsPresenterProtocol: AnyObject {
    var view: CBTipsViewProtocol? { get set }
    var interactor: CBTipsInteractorProtocol? { get set }
    var router: CBTipsRouterProtocol? { get set }

    func viewDidLoad()
    func didSearchTips(with query: String)
    func didTapSearchOnline()
    func didSelectTip(_ tip: CBPlantTip)
    func performOnlineSearch(query: String)
}

// MARK: - Interactor Protocol
protocol CBTipsInteractorProtocol: AnyObject {
    var presenter: CBTipsInteractorOutputProtocol? { get set }

    func fetchTips()
    func filterTips(with searchText: String)
    func searchOnlineTips(query: String)
    func saveTip(_ tip: CBPlantTip)
}

// MARK: - Interactor Output Protocol
protocol CBTipsInteractorOutputProtocol: AnyObject {
    func didFetchTips(_ tips: [CBPlantTip])
    func didFilterTips(_ tips: [CBPlantTip])
    func didFindOnlineTips(_ tips: [CBPlantTip])
    func didSaveTip(_ tip: CBPlantTip)
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol CBTipsRouterProtocol: AnyObject {
    static func createModule() -> UIViewController

    func navigateToTipDetail(_ tip: CBPlantTip, from view: CBTipsViewProtocol?)
}
