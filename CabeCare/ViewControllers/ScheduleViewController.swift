//
//  ScheduleViewController.swift
//  CabeCare
//
//  Displays and manages watering schedules
//

import UIKit

class ScheduleViewController: UIViewController {

    private var schedules: [WateringSchedule] = []

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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "🌶️ Jadwal Penyiraman"
        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupUI()
        loadSchedules()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSchedules()
    }

    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScheduleTapped))
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

    private func loadSchedules() {
        schedules = DataManager.shared.loadSchedules()
        tableView.reloadData()
        updateEmptyState()
    }

    private func updateEmptyState() {
        emptyStateView.isHidden = !schedules.isEmpty
    }

    @objc private func addScheduleTapped() {
        let addVC = AddScheduleViewController()
        addVC.delegate = self
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }

    private func deleteSchedule(at indexPath: IndexPath) {
        let schedule = schedules[indexPath.row]

        // Cancel notifications
        NotificationManager.shared.cancelWateringNotification(for: schedule)

        // Delete from storage
        DataManager.shared.deleteSchedule(schedule)

        // Update UI
        schedules.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        updateEmptyState()
    }

    private func toggleSchedule(at indexPath: IndexPath) {
        var schedule = schedules[indexPath.row]
        schedule.isEnabled.toggle()

        if schedule.isEnabled {
            NotificationManager.shared.scheduleWateringNotification(for: schedule)
        } else {
            NotificationManager.shared.cancelWateringNotification(for: schedule)
        }

        DataManager.shared.updateSchedule(schedule)
        schedules[indexPath.row] = schedule
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! ScheduleCell
        let schedule = schedules[indexPath.row]
        cell.configure(with: schedule)
        cell.switchToggled = { [weak self] isOn in
            self?.toggleSchedule(at: indexPath)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let schedule = schedules[indexPath.row]

        let addVC = AddScheduleViewController()
        addVC.scheduleToEdit = schedule
        addVC.delegate = self
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Hapus") { [weak self] _, _, completion in
            self?.deleteSchedule(at: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - AddScheduleDelegate
extension ScheduleViewController: AddScheduleDelegate {
    func didAddSchedule(_ schedule: WateringSchedule) {
        loadSchedules()
    }

    func didUpdateSchedule(_ schedule: WateringSchedule) {
        loadSchedules()
    }
}
