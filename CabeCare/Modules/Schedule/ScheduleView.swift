//
//  ScheduleView.swift
//  CabeCare
//
//  VIPER View for Schedule Module
//

import UIKit

class ScheduleView: UIViewController {

    var presenter: SchedulePresenterProtocol?

    private var schedules: [WateringSchedule] = []

    // MARK: - UI Components
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.delegate = self
        table.dataSource = self
        table.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    private lazy var emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView(image: UIImage(systemName: "calendar.badge.plus"))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel()
        label.text = "Belum ada jadwal penyiraman\nTap + untuk menambah"
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "🌶️ Jadwal Penyiraman"
        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupUI()

        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    // MARK: - Setup
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
    @objc private func addTapped() {
        presenter?.didTapAddSchedule()
    }
}

// MARK: - ScheduleViewProtocol
extension ScheduleView: ScheduleViewProtocol {
    func showSchedules(_ schedules: [WateringSchedule]) {
        self.schedules = schedules
        tableView.reloadData()
    }

    func showEmptyState() {
        emptyStateView.isHidden = false
    }

    func hideEmptyState() {
        emptyStateView.isHidden = true
    }

    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ScheduleView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        let schedule = schedules[indexPath.row]
        cell.configure(with: schedule)
        cell.switchToggled = { [weak self] isOn in
            self?.presenter?.didToggleSchedule(at: indexPath.row, isEnabled: isOn)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ScheduleView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let schedule = schedules[indexPath.row]
        presenter?.didSelectSchedule(schedule)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Hapus") { [weak self] _, _, completion in
            self?.presenter?.didDeleteSchedule(at: indexPath.row)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
