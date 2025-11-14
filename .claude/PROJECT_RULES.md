# CabeCare Project Rules

## 🏗️ Architecture Rules

### VIPER Architecture (MANDATORY)
**ALWAYS** follow VIPER Clean Architecture for all modules:
- **View**: UIViewController - handles UI and user interactions
- **Interactor**: Business logic and data operations
- **Presenter**: View logic, formats data for display
- **Entity**: Data models (struct/class)
- **Router**: Navigation logic

### Module Structure
```
Modules/
└── [ModuleName]/
    ├── [ModuleName]Contract.swift    ← All protocols
    ├── [ModuleName]View.swift        ← UIViewController
    ├── [ModuleName]Presenter.swift
    ├── [ModuleName]Interactor.swift
    ├── [ModuleName]Router.swift
    └── [ModuleName]Entity.swift      ← (if needed)
```

## 📏 File Size Rules

### Maximum Line Count per File: 200 lines
When a file exceeds 200 lines, split it using extensions:

**Naming Convention for Extensions:**
```swift
// Original file: HomeViewController.swift (200+ lines)
// Split into:

// HomeViewController.swift (main class)
// HomeViewController+TableView.swift
// HomeViewController+CollectionView.swift
// HomeViewController+Delegate.swift
// HomeViewController+Setup.swift
```

**Examples:**
- `ScheduleView.swift` → `ScheduleView+TableView.swift`
- `TipsPresenter.swift` → `TipsPresenter+DataHandling.swift`
- `ProfileInteractor.swift` → `ProfileInteractor+Networking.swift`

## 🗂️ File Separation Rules

### Rule 1: One Class/Struct per File (MANDATORY)
**NEVER** put multiple classes or structs in the same file.

❌ **BAD:**
```swift
// TabBarView.swift
class TabBarView: UIViewController { }
class CustomTabBarView: UIView { }
class TabBarButton: UIButton { }
```

✅ **GOOD:**
```swift
// TabBarView.swift
class TabBarView: UIViewController { }

// CustomTabBarView.swift
class CustomTabBarView: UIView { }

// TabBarButton.swift
class TabBarButton: UIButton { }
```

### Rule 2: Protocol Location
- **Module-specific protocols**: Place in `[ModuleName]Contract.swift`
- **Shared protocols**: Place in `Common/Protocols/`
- **Delegate protocols for components**: Keep with the component class

### Rule 3: UI Components Location
Place reusable UI components in:
```
Common/
└── Views/
    ├── CustomButton.swift
    ├── CustomTextField.swift
    ├── TableViewCells/
    │   ├── UserCell.swift
    │   └── ProductCell.swift
    └── CustomViews/
        ├── HeaderView.swift
        └── LoadingView.swift
```

## 🎯 Naming Conventions

### View Controllers
- Pattern: `[Feature]View.swift` or `[Feature]ViewController.swift`
- Examples: `HomeView.swift`, `ScheduleView.swift`

### VIPER Components
- Contract: `[Feature]Contract.swift`
- View: `[Feature]View.swift`
- Presenter: `[Feature]Presenter.swift`
- Interactor: `[Feature]Interactor.swift`
- Router: `[Feature]Router.swift`
- Entity: `[Feature]Entity.swift`

### UI Components
- Pattern: `[Purpose][ComponentType].swift`
- Examples: `CustomTabBarView.swift`, `TabBarButton.swift`, `UserProfileCell.swift`

### Extensions
- Pattern: `[ClassName]+[Purpose].swift`
- Examples:
  - `HomeView+TableView.swift`
  - `SchedulePresenter+DateFormatting.swift`
  - `ProfileInteractor+Networking.swift`

## 🔧 Code Quality Rules

### 1. MARK Comments (MANDATORY)
Always use MARK comments for organization:
```swift
// MARK: - Properties
// MARK: - Initialization
// MARK: - Lifecycle
// MARK: - Setup
// MARK: - Actions
// MARK: - Private Methods
// MARK: - Public Methods
// MARK: - [ProtocolName]
```

### 2. Access Control
- Use `private` for internal implementations
- Use `fileprivate` only when needed for extensions in same file
- Use `internal` (default) for module-internal access
- Use `public` only for framework/library code

### 3. Avoid Property Name Conflicts
When subclassing UIKit classes, be careful with property names:

❌ **BAD:**
```swift
class TabBarButton: UIButton {
    private let titleLabel: UILabel  // ← Conflicts with UIButton.titleLabel
}
```

✅ **GOOD:**
```swift
class TabBarButton: UIButton {
    private let tabTitleLabel: UILabel  // ← No conflict
}
```

### 4. Dependency Injection
Always use dependency injection via initializers or properties:
```swift
// Router creates and connects VIPER components
static func createModule() -> UIViewController {
    let view = ScheduleView()
    let presenter = SchedulePresenter()
    let interactor = ScheduleInteractor()
    let router = ScheduleRouter()

    view.presenter = presenter
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    interactor.presenter = presenter

    return view
}
```

## 📦 Common Folder Structure

```
Common/
├── Managers/
│   ├── DataManager.swift
│   └── NotificationManager.swift
├── Views/
│   ├── Cells/
│   ├── CustomViews/
│   └── Reusable/
├── Extensions/
│   ├── UIView+Extensions.swift
│   └── String+Extensions.swift
├── Protocols/
│   └── SharedProtocols.swift
└── Utils/
    └── Constants.swift
```

## 🚫 What to Avoid

1. **NO Massive View Controllers** - Split into extensions when > 200 lines
2. **NO God Objects** - Single Responsibility Principle
3. **NO Business Logic in Views** - Use Presenter/Interactor
4. **NO Direct Data Access in Views** - Use Interactor
5. **NO Navigation in Views** - Use Router
6. **NO Multiple Classes per File** - One class = One file
7. **NO Singletons** - Use Dependency Injection instead

## ✅ Best Practices

### 1. Protocol-Oriented Programming
```swift
protocol ScheduleViewProtocol: AnyObject {
    var presenter: SchedulePresenterProtocol? { get set }
    func showSchedules(_ schedules: [WateringSchedule])
}
```

### 2. Weak References for Delegates
```swift
weak var delegate: CustomTabBarViewDelegate?
weak var view: ScheduleViewProtocol?
weak var presenter: ScheduleInteractorOutputProtocol?
```

### 3. Clear Method Names
```swift
// Good
func didTapAddButton()
func fetchUserProfile()
func navigateToSettings()

// Bad
func tap()
func get()
func go()
```

### 4. Group Related Code with Extensions
```swift
// MARK: - UITableViewDataSource
extension ScheduleView: UITableViewDataSource {
    // All dataSource methods here
}

// MARK: - UITableViewDelegate
extension ScheduleView: UITableViewDelegate {
    // All delegate methods here
}
```

## 🔄 When to Create New Files

### Split a file when:
1. ✅ File exceeds 200 lines
2. ✅ Multiple classes/structs in one file
3. ✅ Multiple protocols that aren't related to the same module
4. ✅ Extension logic becomes too complex (> 50 lines)

### Create extension file when:
- TableView/CollectionView delegate methods grow large
- Complex setup methods need separation
- Helper methods can be grouped logically
- Protocol conformance adds significant code

## 📝 Comments and Documentation

```swift
//
//  FileName.swift
//  CabeCare
//
//  Brief description of what this file does
//

import UIKit

/// Detailed class description
class ScheduleView: UIViewController {

    // MARK: - Properties

    /// Reference to the presenter
    var presenter: SchedulePresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
}
```

## 🎨 UI Layout Rules

### Use Auto Layout Programmatically
```swift
private func setupUI() {
    view.addSubview(tableView)

    NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
}
```

## 🔒 Error Handling

```swift
// Use proper error handling
do {
    try saveData()
} catch {
    presenter?.didFailWithError(error)
}

// Define custom errors
enum ScheduleError: Error {
    case invalidDate
    case duplicateSchedule
    case saveFailed
}
```

---

## 📌 Summary Checklist

Before committing code, ensure:
- [ ] Following VIPER architecture
- [ ] One class per file
- [ ] Files under 200 lines (split if needed)
- [ ] Proper MARK comments
- [ ] Clear naming conventions
- [ ] No business logic in Views
- [ ] Weak references for delegates
- [ ] Proper access control
- [ ] No hardcoded strings/values
- [ ] Clean and readable code

---

**Remember:** Clean Code + VIPER Architecture = Maintainable and Scalable App! 🚀
