//
//  CBTabBarButton.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Custom tab bar button component
//

import UIKit

class CBTabBarButton: UIButton {

    let index: Int

    var isSelectedTab: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let tabTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()

    // MARK: - Initialization

    init(icon: String, title: String, index: Int) {
        self.index = index
        super.init(frame: .zero)

        setupUI()
        iconImageView.image = UIImage(systemName: icon)
        tabTitleLabel.text = title
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        addSubview(containerStack)

        containerStack.addArrangedSubview(iconImageView)
        containerStack.addArrangedSubview(tabTitleLabel)

        NSLayoutConstraint.activate([
            containerStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerStack.centerYAnchor.constraint(equalTo: centerYAnchor),

            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func updateAppearance() {
        let color: UIColor = isSelectedTab ? .white : .gray
        iconImageView.tintColor = color
        tabTitleLabel.textColor = color
    }
}
