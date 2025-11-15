//
//  TipsViewController.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Browse and search plant care tips
//

import UIKit

class TipsViewController: UIViewController {

    private var allTips: [CBPlantTip] = []
    private var displayedTips: [CBPlantTip] = []

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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "💡 " + TipsLandingLK.screenTitle.localized
        view.backgroundColor = .systemBackground

        setupSearchController()
        setupUI()
        loadTips()
    }

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

        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadTips() {
        // Load predefined tips
        allTips = CBTipsSearchManager.shared.getAllTips()

        // Load saved tips from storage
        let savedTips = CBDataManager.shared.loadTips()

        // Combine and remove duplicates
        for savedTip in savedTips {
            if !allTips.contains(where: { $0.id == savedTip.id }) {
                allTips.insert(savedTip, at: 0)
            }
        }

        displayedTips = allTips
        tableView.reloadData()
    }

    @objc private func searchOnlineTapped() {
        let alert = UIAlertController(title: TipsAlertLK.addTipAlertTitle.localized, message: TipsAlertLK.addTipAlertMessage.localized, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = TipsLandingLK.searchQueryPlaceholder.localized
        }

        alert.addAction(UIAlertAction(title: CommonLK.cancelButton.localized, style: .cancel))
        alert.addAction(UIAlertAction(title: TipsAlertLK.searchButton.localized, style: .default) { [weak self] _ in
            guard let query = alert.textFields?.first?.text, !query.isEmpty else { return }
            self?.performOnlineSearch(query: query)
        })

        present(alert, animated: true)
    }

    private func performOnlineSearch(query: String) {
        // Show loading indicator
        let loadingAlert = UIAlertController(title: CommonLK.loading.localized, message: TipsAlertLK.loadingMessage.localized, preferredStyle: .alert)
        present(loadingAlert, animated: true)

        // Search for tips
        CBTipsSearchManager.shared.searchTips(query: query) { [weak self] tips in
            guard let self = self else { return }

            // Dismiss loading alert
            loadingAlert.dismiss(animated: true) {
                if tips.isEmpty {
                    self.showAlert(title: TipsAlertLK.notFoundTitle.localized, message: TipsAlertLK.notFoundMessage.localized)
                } else {
                    // Save first tip and send notification
                    let firstTip = tips[0]
                    CBDataManager.shared.addTip(firstTip)
                    CBNotificationManager.shared.sendTipNotification(tip: firstTip)

                    // Reload tips
                    self.loadTips()

                    // Show result
                    self.showAlert(title: TipsAlertLK.tipAddedSuccessMessage.localized, message: TipsAlertLK.tipAddedWithNotificationMessage.localized)
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonLK.okButton.localized, style: .default))
        present(alert, animated: true)
    }

    private func filterTips(with searchText: String) {
        if searchText.isEmpty {
            displayedTips = allTips
        } else {
            displayedTips = allTips.filter { tip in
                tip.title.lowercased().contains(searchText.lowercased()) ||
                tip.content.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension TipsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedTips.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TipsConstants.CellIdentifier.tipCell.value, for: indexPath) as! CBTipCell
        let tip = displayedTips[indexPath.row]
        cell.configure(with: tip)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TipsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let tip = displayedTips[indexPath.row]
        let detailVC = TipDetailViewController(tip: tip)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UISearchResultsUpdating
extension TipsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterTips(with: searchText)
    }
}
