//
//  TipDetailContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for TipDetail Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol CBTipDetailViewProtocol: AnyObject {
    var presenter: CBTipDetailPresenterProtocol? { get set }

    func showTipDetail(title: String, content: String, source: String?)
}

// MARK: - Presenter Protocol
protocol CBTipDetailPresenterProtocol: AnyObject {
    var view: CBTipDetailViewProtocol? { get set }
    var interactor: CBTipDetailInteractorProtocol? { get set }
    var router: CBTipDetailRouterProtocol? { get set }

    func viewDidLoad()
    func didTapShare()
}

// MARK: - Interactor Protocol
protocol CBTipDetailInteractorProtocol: AnyObject {
    var presenter: CBTipDetailInteractorOutputProtocol? { get set }
    var tip: CBPlantTip? { get set }

    func fetchTipDetail()
    func getShareText() -> String
}

// MARK: - Interactor Output Protocol
protocol CBTipDetailInteractorOutputProtocol: AnyObject {
    func didFetchTipDetail(title: String, content: String, source: String?)
}

// MARK: - Router Protocol
protocol CBTipDetailRouterProtocol: AnyObject {
    static func createModule(tip: CBPlantTip) -> UIViewController

    func presentShareSheet(with text: String, from view: CBTipDetailViewProtocol?, sourceView: UIView?)
}
