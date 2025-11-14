//
//  TabBarView.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  TabBar View Controller
//

import UIKit

class TabBarView: UIViewController {

    // MARK: - Properties
    var presenter: TabBarPresenterProtocol?

    private var viewControllers: [UIViewController] = []
    private var selectedIndex: Int = 0 {
        didSet {
            transitionToViewController(at: selectedIndex)
        }
    }

    private let customTabBar: CBTabBarView = {
        let view = CBTabBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var currentViewController: UIViewController?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyRoundedCorners()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .black

        view.addSubview(contentContainerView)
        view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            // Content container constraints
            contentContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            contentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: customTabBar.topAnchor),

            // Custom tab bar constraints
            customTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        customTabBar.delegate = self
    }

    private func applyRoundedCorners() {
        let path = UIBezierPath(
            roundedRect: contentContainerView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 40, height: 40)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        contentContainerView.layer.mask = maskLayer
    }

    // MARK: - View Controller Management

    private func transitionToViewController(at index: Int) {
        guard index >= 0 && index < viewControllers.count else { return }

        let newViewController = viewControllers[index]

        // Remove current view controller
        if let current = currentViewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }

        // Add new view controller
        addChild(newViewController)
        newViewController.view.frame = contentContainerView.bounds
        newViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentContainerView.addSubview(newViewController.view)
        newViewController.didMove(toParent: self)

        currentViewController = newViewController
    }
}

// MARK: - TabBarViewProtocol

extension TabBarView: TabBarViewProtocol {

    func setupTabBar(with viewControllers: [UIViewController], tabItems: [CBTabBarEntity]) {
        self.viewControllers = viewControllers
        customTabBar.configure(with: tabItems)

        // Show first view controller
        if !viewControllers.isEmpty {
            transitionToViewController(at: 0)
        }
    }

    func selectTab(at index: Int) {
        guard index >= 0 && index < viewControllers.count else { return }
        selectedIndex = index
        customTabBar.selectTab(at: index)
    }
}

// MARK: - CBTabBarViewDelegate

extension TabBarView: CBTabBarViewDelegate {
    func didSelectTab(at index: Int) {
        presenter?.didSelectTab(at: index)
    }
}
