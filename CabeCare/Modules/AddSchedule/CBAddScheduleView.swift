//
//  AddScheduleView.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  VIPER View for AddSchedule Module
//

import UIKit

class CBAddScheduleView: UIViewController {

    var presenter: CBAddSchedulePresenterProtocol?

    private var isEditMode: Bool = false
    private let intervals = CBWateringSchedule.RepeatInterval.allCases

    // MARK: - UI Components
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

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground

        setupNavigationBar()
        setupUI()
        setupPickerView()

        presenter?.viewDidLoad()
    }

    // MARK: - Setup
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTapped)
        )
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

    private func updateTitle() {
        title = isEditMode ? AddScheduleLK.screenTitleEdit.localized : AddScheduleLK.screenTitleAdd.localized
    }

    // MARK: - Actions
    @objc private func cancelTapped() {
        presenter?.didTapCancel()
    }

    @objc private func saveTapped() {
        let selectedInterval = intervals[intervalPicker.selectedRow(inComponent: 0)]
        presenter?.didTapSave(
            plantName: plantNameTextField.text,
            time: timePicker.date,
            interval: selectedInterval,
            notes: notesTextField.text
        )
    }
}

// MARK: - CBAddScheduleViewProtocol
extension CBAddScheduleView: CBAddScheduleViewProtocol {
    func showScheduleData(plantName: String, time: Date, interval: CBWateringSchedule.RepeatInterval, notes: String?) {
        isEditMode = true
        updateTitle()

        plantNameTextField.text = plantName
        timePicker.date = time
        notesTextField.text = notes

        if let index = intervals.firstIndex(of: interval) {
            intervalPicker.selectRow(index, inComponent: 0, animated: false)
        }
    }

    func showValidationError(message: String) {
        let alert = UIAlertController(
            title: CommonLK.warningTitle.localized,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: CommonLK.okButton.localized, style: .default))
        present(alert, animated: true)
    }

    func dismissView() {
        dismiss(animated: true)
    }
}

// MARK: - UIPickerViewDataSource
extension CBAddScheduleView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return intervals.count
    }
}

// MARK: - UIPickerViewDelegate
extension CBAddScheduleView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return intervals[row].rawValue
    }
}
