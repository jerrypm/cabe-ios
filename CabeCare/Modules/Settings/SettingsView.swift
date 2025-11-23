//
//  SettingsView.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 23/11/25.
//  Settings View Controller
//

import UIKit

class SettingsView: UIViewController {

    // MARK: - Properties
    var presenter: SettingsPresenterProtocol?

    private var languages: [LanguageEntity] = []

    // MARK: - UI Components

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.backgroundColor = .systemBackground
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.identifier)
        return table
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Setup

    private func setupUI() {
        title = SettingsLK.screenTitle.localized
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SettingsViewProtocol

extension SettingsView: SettingsViewProtocol {

    func showLanguageOptions(_ languages: [LanguageEntity]) {
        self.languages = languages
        tableView.reloadData()
    }

    func updateSelectedLanguage(_ language: LanguageEntity) {
        // Update UI to reflect selected language
        if let index = languages.firstIndex(where: { $0.code == language.code }) {
            languages = languages.map { lang in
                var updatedLang = lang
                updatedLang.isSelected = (lang.code == language.code)
                return updatedLang
            }
            tableView.reloadData()

            // Show alert to restart app
            showRestartAlert()
        }
    }

    private func showRestartAlert() {
        let alert = UIAlertController(
            title: SettingsLK.restartAlertTitle.localized,
            message: SettingsLK.restartAlertMessage.localized,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: SettingsLK.restartAlertOK.localized, style: .default) { _ in
            // User can manually restart the app
        })

        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension SettingsView: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.identifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }

        let language = languages[indexPath.row]
        cell.configure(with: language)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsLK.languageSectionTitle.localized
    }
}

// MARK: - UITableViewDelegate

extension SettingsView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedLanguage = languages[indexPath.row]
        presenter?.didSelectLanguage(selectedLanguage)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Language Cell

class LanguageCell: UITableViewCell {

    static let identifier = "LanguageCell"

    // MARK: - UI Components

    private let flagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let languageNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let nativeNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupUI() {
        contentView.addSubview(flagLabel)
        contentView.addSubview(languageNameLabel)
        contentView.addSubview(nativeNameLabel)
        contentView.addSubview(checkmarkImageView)

        NSLayoutConstraint.activate([
            flagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            flagLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            flagLabel.widthAnchor.constraint(equalToConstant: 40),

            languageNameLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 12),
            languageNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

            nativeNameLabel.leadingAnchor.constraint(equalTo: flagLabel.trailingAnchor, constant: 12),
            nativeNameLabel.topAnchor.constraint(equalTo: languageNameLabel.bottomAnchor, constant: 2),
            nativeNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            checkmarkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 20),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: - Configuration

    func configure(with language: LanguageEntity) {
        languageNameLabel.text = language.name
        nativeNameLabel.text = language.nativeName
        checkmarkImageView.isHidden = !language.isSelected

        // Set flag emoji
        switch language.code {
        case "en":
            flagLabel.text = "🇬🇧"
        case "id":
            flagLabel.text = "🇮🇩"
        default:
            flagLabel.text = "🌐"
        }
    }
}
