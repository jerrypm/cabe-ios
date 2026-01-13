//
//  TipsView.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER View for Tips Module
//

import UIKit

class CBTipsView: UIViewController {

    var presenter: CBTipsPresenterProtocol?

    private var tips: [CBPlantTip] = []

    // MARK: - UI Components
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = TipsLandingLK.searchPlaceholder.localized
        return controller
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(CBTipCell.self, forCellReuseIdentifier: TipsConstants.CellIdentifier.tipCell.value)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = TipsLandingLK.searchOnlineButton.localized
        config.image = UIImage(systemName: "magnifyingglass")
        config.imagePadding = 8
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .medium

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(searchOnlineTapped), for: .touchUpInside)
        return button
    }()

    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true

        let imageView = UIImageView(image: UIImage(systemName: "lightbulb"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = TipsLandingLK.emptyStateMessage.localized
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(label)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),

            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        return view
    }()

    private var loadingAlert: UIAlertController?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "💡 " + TipsLandingLK.screenTitle.localized
        view.backgroundColor = .systemBackground

        setupSearchController()
        setupUI()

        presenter?.viewDidLoad()
    }

    // MARK: - Setup
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func setupUI() {
        view.addSubview(searchButton)
        view.addSubview(tableView)
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emptyStateView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Actions
    @objc private func searchOnlineTapped() {
        let alert = UIAlertController(
            title: TipsAlertLK.addTipAlertTitle.localized,
            message: TipsAlertLK.addTipAlertMessage.localized,
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = TipsLandingLK.searchQueryPlaceholder.localized
        }

        alert.addAction(UIAlertAction(title: CommonLK.cancelButton.localized, style: .cancel))
        alert.addAction(UIAlertAction(title: TipsAlertLK.searchButton.localized, style: .default) { [weak self] _ in
            guard let query = alert.textFields?.first?.text, !query.isEmpty else { return }
            self?.presenter?.performOnlineSearch(query: query)
        })

        present(alert, animated: true)
    }
}

// MARK: - CBTipsViewProtocol
extension CBTipsView: CBTipsViewProtocol {
    func showTips(_ tips: [CBPlantTip]) {
        self.tips = tips
        tableView.reloadData()
    }

    func showEmptyState() {
        emptyStateView.isHidden = false
    }

    func hideEmptyState() {
        emptyStateView.isHidden = true
    }

    func showLoading() {
        loadingAlert = UIAlertController(
            title: CommonLK.loading.localized,
            message: TipsAlertLK.loadingMessage.localized,
            preferredStyle: .alert
        )
        if let alert = loadingAlert {
            present(alert, animated: true)
        }
    }

    func hideLoading() {
        loadingAlert?.dismiss(animated: true)
        loadingAlert = nil
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonLK.okButton.localized, style: .default))
        present(alert, animated: true)
    }

    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension CBTipsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TipsConstants.CellIdentifier.tipCell.value,
            for: indexPath
        ) as! CBTipCell
        let tip = tips[indexPath.row]
        cell.configure(with: tip)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CBTipsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tip = tips[indexPath.row]
        presenter?.didSelectTip(tip)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UISearchResultsUpdating
extension CBTipsView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        presenter?.didSearchTips(with: searchText)
    }
}
