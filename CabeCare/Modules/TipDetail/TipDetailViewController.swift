//
//  TipDetailViewController.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Displays detailed view of a plant care tip
//

import UIKit

class TipDetailViewController: UIViewController {

    private let tip: CBPlantTip

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconLabel: UILabel = {
        let label = UILabel()
        label.text = "💡"
        label.font = .systemFont(ofSize: 60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var shareButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = TipDetailLK.shareButton.localized
        config.image = UIImage(systemName: "square.and.arrow.up")
        config.imagePadding = 8
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .medium

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()

    init(tip: CBPlantTip) {
        self.tip = tip
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = TipDetailLK.screenTitle.localized
        view.backgroundColor = .systemBackground

        setupUI()
        populateContent()
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(shareButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            iconLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            iconLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            sourceLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 24),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            shareButton.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 32),
            shareButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 200),
            shareButton.heightAnchor.constraint(equalToConstant: 50),
            shareButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }

    private func populateContent() {
        titleLabel.text = tip.title
        contentLabel.text = tip.content

        if let source = tip.source {
            sourceLabel.text = TipDetailLK.sourceLabel.localized(with: ["source": source])
        } else {
            sourceLabel.isHidden = true
        }
    }

    @objc private func shareTapped() {
        let sourceText = tip.source.map { TipDetailLK.sourceLabel.localized(with: ["source": $0]) } ?? ""
        let text = TipDetailLK.shareTextTemplate.localized(with: [
            "title": tip.title,
            "content": tip.content,
            "source": sourceText
        ])

        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = shareButton

        present(activityVC, animated: true)
    }
}
