//
//  AddScheduleViewController.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Add or edit watering schedule
//

import UIKit

protocol AddScheduleDelegate: AnyObject {
    func didAddSchedule(_ schedule: CBWateringSchedule)
    func didUpdateSchedule(_ schedule: CBWateringSchedule)
}

class AddScheduleViewController: UIViewController {

    weak var delegate: AddScheduleDelegate?
    var scheduleToEdit: CBWateringSchedule?

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

    private let plantNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AddScheduleLK.plantNamePlaceholder.localized
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = AddScheduleLK.wateringTimeLabel.localized
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let intervalLabel: UILabel = {
        let label = UILabel()
        label.text = AddScheduleLK.intervalLabel.localized
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let intervalPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let notesTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = AddScheduleLK.notesPlaceholder.localized
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let intervals = CBWateringSchedule.RepeatInterval.allCases

    override func viewDidLoad() {
        super.viewDidLoad()

        title = scheduleToEdit == nil ? AddScheduleLK.screenTitleAdd.localized : AddScheduleLK.screenTitleEdit.localized
        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupUI()
        setupPickerView()

        if let schedule = scheduleToEdit {
            populateFields(with: schedule)
        }
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(plantNameTextField)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timePicker)
        contentView.addSubview(intervalLabel)
        contentView.addSubview(intervalPicker)
        contentView.addSubview(notesTextField)

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

            plantNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            plantNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            plantNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            plantNameTextField.heightAnchor.constraint(equalToConstant: 44),

            timeLabel.topAnchor.constraint(equalTo: plantNameTextField.bottomAnchor, constant: 24),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            timePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            timePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            intervalLabel.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 24),
            intervalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            intervalPicker.topAnchor.constraint(equalTo: intervalLabel.bottomAnchor, constant: 8),
            intervalPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            intervalPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            intervalPicker.heightAnchor.constraint(equalToConstant: 120),

            notesTextField.topAnchor.constraint(equalTo: intervalPicker.bottomAnchor, constant: 24),
            notesTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            notesTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            notesTextField.heightAnchor.constraint(equalToConstant: 44),
            notesTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func setupPickerView() {
        intervalPicker.delegate = self
        intervalPicker.dataSource = self
    }

    private func populateFields(with schedule: CBWateringSchedule) {
        plantNameTextField.text = schedule.plantName
        timePicker.date = schedule.wateringTime
        notesTextField.text = schedule.notes

        if let index = intervals.firstIndex(of: schedule.repeatInterval) {
            intervalPicker.selectRow(index, inComponent: 0, animated: false)
        }
    }

    @objc private func cancelTapped() {
        dismiss(animated: true)
    }

    @objc private func saveTapped() {
        guard let plantName = plantNameTextField.text, !plantName.isEmpty else {
            showAlert(message: CommonLK.plantNameTitle.localized)
            return
        }

        let selectedInterval = intervals[intervalPicker.selectedRow(inComponent: 0)]
        let notes = notesTextField.text

        if let existingSchedule = scheduleToEdit {
            // Update existing schedule
            var updatedSchedule = existingSchedule
            updatedSchedule.plantName = plantName
            updatedSchedule.wateringTime = timePicker.date
            updatedSchedule.repeatInterval = selectedInterval
            updatedSchedule.notes = notes

            // Cancel old notifications
            CBNotificationManager.shared.cancelWateringNotification(for: existingSchedule)

            // Schedule new notifications
            CBNotificationManager.shared.scheduleWateringNotification(for: updatedSchedule)

            // Save
            CBDataManager.shared.updateSchedule(updatedSchedule)
            delegate?.didUpdateSchedule(updatedSchedule)
        } else {
            // Create new schedule
            let schedule = CBWateringSchedule(
                plantName: plantName,
                wateringTime: timePicker.date,
                repeatInterval: selectedInterval,
                notes: notes
            )

            // Schedule notifications
            CBNotificationManager.shared.scheduleWateringNotification(for: schedule)

            // Save
            CBDataManager.shared.addSchedule(schedule)
            delegate?.didAddSchedule(schedule)
        }

        dismiss(animated: true)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: CommonLK.warningTitle.localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CommonLK.okButton.localized, style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension AddScheduleViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervals.count
    }
}

// MARK: - UIPickerViewDelegate
extension AddScheduleViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervals[row].rawValue
    }
}
