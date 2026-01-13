//
//  ScheduleContract.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER Contract for Schedule Module
//

import Foundation
import UIKit

// MARK: - View Protocol
protocol CBScheduleViewProtocol: AnyObject {
    var presenter: CBSchedulePresenterProtocol? { get set }

    func showSchedules(_ schedules: [CBWateringSchedule])
    func showEmptyState()
    func hideEmptyState()
    func reloadData()
}

// MARK: - Presenter Protocol
protocol CBSchedulePresenterProtocol: AnyObject {
    var view: CBScheduleViewProtocol? { get set }
    var interactor: CBScheduleInteractorProtocol? { get set }
    var router: CBScheduleRouterProtocol? { get set }

    func viewDidLoad()
    func viewWillAppear()
    func didTapAddSchedule()
    func didSelectSchedule(_ schedule: CBWateringSchedule)
    func didToggleSchedule(at index: Int, isEnabled: Bool)
    func didDeleteSchedule(at index: Int)
}

// MARK: - Interactor Protocol
protocol CBScheduleInteractorProtocol: AnyObject {
    var presenter: CBScheduleInteractorOutputProtocol? { get set }

    func fetchSchedules()
    func toggleSchedule(_ schedule: CBWateringSchedule, isEnabled: Bool)
    func deleteSchedule(_ schedule: CBWateringSchedule)
}

// MARK: - Interactor Output Protocol
protocol CBScheduleInteractorOutputProtocol: AnyObject {
    func didFetchSchedules(_ schedules: [CBWateringSchedule])
    func didUpdateSchedule()
    func didDeleteSchedule()
    func didFailWithError(_ error: Error)
}

// MARK: - Router Protocol
protocol CBScheduleRouterProtocol: AnyObject {
    static func createModule() -> UIViewController

    func navigateToAddSchedule(from view: CBScheduleViewProtocol?)
    func navigateToEditSchedule(_ schedule: CBWateringSchedule, from view: CBScheduleViewProtocol?)
}
