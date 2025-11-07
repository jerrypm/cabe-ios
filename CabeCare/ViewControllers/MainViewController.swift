//
//  MainViewController.swift
//  CabeCare
//
//  Main tab controller for the app
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
        setupAppearance()
    }

    private func setupViewControllers() {
        // Schedule View Controller
        let scheduleVC = ScheduleViewController()
        scheduleVC.tabBarItem = UITabBarItem(
            title: "Jadwal",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar.fill")
        )

        // Tips View Controller
        let tipsVC = TipsViewController()
        tipsVC.tabBarItem = UITabBarItem(
            title: "Tips",
            image: UIImage(systemName: "lightbulb"),
            selectedImage: UIImage(systemName: "lightbulb.fill")
        )

        // Set view controllers
        viewControllers = [scheduleVC, tipsVC]
    }

    private func setupAppearance() {
        // Tab bar appearance
        tabBar.tintColor = .systemGreen
        tabBar.backgroundColor = .systemBackground

        // Navigation bar appearance
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
