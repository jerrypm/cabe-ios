//
//  CBScheduleCell.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Custom cell for watering schedule
//

import UIKit

class CBScheduleCell: UITableViewCell {

    var switchToggled: ((Bool) -> Void)?

    private let plantIconLabel: UILabel = {
        let label = UILabel()
        label.text = "🌶️"
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let plantNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let intervalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let enableSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.onTintColor = .systemGreen
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(plantIconLabel)
        contentView.addSubview(plantNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(intervalLabel)
        contentView.addSubview(enableSwitch)

        enableSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)

        NSLayoutConstraint.activate([
            plantIconLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            plantIconLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plantIconLabel.widthAnchor.constraint(equalToConstant: 40),

            plantNameLabel.leadingAnchor.constraint(equalTo: plantIconLabel.trailingAnchor, constant: 12),
            plantNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            plantNameLabel.trailingAnchor.constraint(equalTo: enableSwitch.leadingAnchor, constant: -8),

            timeLabel.leadingAnchor.constraint(equalTo: plantNameLabel.leadingAnchor),
            timeLabel.topAnchor.constraint(equalTo: plantNameLabel.bottomAnchor, constant: 4),
            timeLabel.trailingAnchor.constraint(equalTo: plantNameLabel.trailingAnchor),

            intervalLabel.leadingAnchor.constraint(equalTo: plantNameLabel.leadingAnchor),
            intervalLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),
            intervalLabel.trailingAnchor.constraint(equalTo: plantNameLabel.trailingAnchor),

            enableSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            enableSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(with schedule: CBWateringSchedule) {
        plantNameLabel.text = schedule.plantName

        let formatter = DateFormatter()
        formatter.dateFormat = ScheduleConstants.DateFormat.time.value
        timeLabel.text = "⏰ " + formatter.string(from: schedule.wateringTime)

        intervalLabel.text = "🔁 " + schedule.repeatInterval.rawValue

        enableSwitch.isOn = schedule.isEnabled
    }

    @objc private func switchValueChanged() {
        switchToggled?(enableSwitch.isOn)
    }
}
