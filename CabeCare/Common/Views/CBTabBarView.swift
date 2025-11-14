//
//  CBTabBarView.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Custom tab bar view component
//

import UIKit

protocol CBTabBarViewDelegate: AnyObject {
    func didSelectTab(at index: Int)
}

class CBTabBarView: UIView {

    weak var delegate: CBTabBarViewDelegate?

    private var selectedIndex: Int = 0 {
        didSet {
            updateTabSelection()
        }
    }

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let homeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var tabButtons: [CBTabBarButton] = []

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        backgroundColor = .black

        addSubview(stackView)
        addSubview(homeIndicator)

        NSLayoutConstraint.activate([
            // Stack view constraints
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 50),

            // Home indicator constraints
            homeIndicator.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            homeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            homeIndicator.widthAnchor.constraint(equalToConstant: 134),
            homeIndicator.heightAnchor.constraint(equalToConstant: 5),
            homeIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Public Methods

    func configure(with items: [CBTabBarEntity]) {
        // Clear existing buttons
        tabButtons.forEach { $0.removeFromSuperview() }
        tabButtons.removeAll()

        // Create new buttons
        for (index, item) in items.enumerated() {
            let button = CBTabBarButton(icon: item.icon, title: item.title, index: index)
            button.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
            tabButtons.append(button)
            stackView.addArrangedSubview(button)
        }

        // Set first tab as selected
        if !tabButtons.isEmpty {
            tabButtons[0].isSelectedTab = true
        }
    }

    func selectTab(at index: Int) {
        guard index >= 0 && index < tabButtons.count else { return }
        selectedIndex = index
    }

    // MARK: - Actions

    @objc private func tabButtonTapped(_ sender: CBTabBarButton) {
        selectedIndex = sender.index
        delegate?.didSelectTab(at: sender.index)
    }

    private func updateTabSelection() {
        for (index, button) in tabButtons.enumerated() {
            button.isSelectedTab = (index == selectedIndex)
        }
    }
}
