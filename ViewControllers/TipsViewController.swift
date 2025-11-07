//
//  TipsViewController.swift
//  CabeCare
//
//  Browse and search plant care tips
//

import UIKit

class TipsViewController: UIViewController {

    private var allTips: [PlantTip] = []
    private var displayedTips: [PlantTip] = []

    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchBar.placeholder = "Cari tips perawatan cabe..."
        return controller
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(TipCell.self, forCellReuseIdentifier: "TipCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var searchButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Cari Tips di Internet"
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

        title = "💡 Tips Perawatan"
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
        allTips = TipsSearchManager.shared.getAllTips()

        // Load saved tips from storage
        let savedTips = DataManager.shared.loadTips()

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
        let alert = UIAlertController(title: "Cari Tips", message: "Masukkan kata kunci untuk mencari tips", preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = "contoh: penyiraman, pemupukan"
        }

        alert.addAction(UIAlertAction(title: "Batal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Cari", style: .default) { [weak self] _ in
            guard let query = alert.textFields?.first?.text, !query.isEmpty else { return }
            self?.performOnlineSearch(query: query)
        })

        present(alert, animated: true)
    }

    private func performOnlineSearch(query: String) {
        // Show loading indicator
        let loadingAlert = UIAlertController(title: "Mencari...", message: "Mohon tunggu sebentar", preferredStyle: .alert)
        present(loadingAlert, animated: true)

        // Search for tips
        TipsSearchManager.shared.searchTips(query: query) { [weak self] tips in
            guard let self = self else { return }

            // Dismiss loading alert
            loadingAlert.dismiss(animated: true) {
                if tips.isEmpty {
                    self.showAlert(title: "Tidak Ditemukan", message: "Tidak ada tips yang sesuai dengan pencarian Anda")
                } else {
                    // Save first tip and send notification
                    let firstTip = tips[0]
                    DataManager.shared.addTip(firstTip)
                    NotificationManager.shared.sendTipNotification(tip: firstTip)

                    // Reload tips
                    self.loadTips()

                    // Show result
                    self.showAlert(title: "Tips Ditemukan!", message: "Tips baru telah ditambahkan dan notifikasi dikirim")
                }
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell", for: indexPath) as! TipCell
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
