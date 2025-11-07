# 🏗️ VIPER Clean Architecture - CabeCare

## 📐 Architecture Overview

Aplikasi ini menggunakan **VIPER (View-Interactor-Presenter-Entity-Router)** Clean Architecture pattern untuk separation of concerns yang lebih baik.

### VIPER Components:

```
┌─────────────────────────────────────────────────────────┐
│                         VIEW                             │
│  (UIViewController - Handles UI & User Interactions)    │
└───────────────┬─────────────────────────────────────────┘
                │ ▲
                │ │ Updates UI
                ▼ │
┌─────────────────────────────────────────────────────────┐
│                       PRESENTER                          │
│   (Coordinator - Handles presentation logic)            │
└───┬────────────────────────────────────────────┬────────┘
    │ ▲                                           │
    │ │ Business Logic Results                    │ Navigation
    ▼ │                                           ▼
┌────────────────────────┐              ┌────────────────┐
│     INTERACTOR         │              │     ROUTER     │
│  (Business Logic)      │              │  (Navigation)  │
└──┬─────────────────────┘              └────────────────┘
   │ ▲
   │ │ Data
   ▼ │
┌────────────────────────┐
│       ENTITY           │
│    (Data Models)       │
└────────────────────────┘
```

## 📁 Project Structure

```
CabeCare/
├── App/                              # Application lifecycle
│   ├── AppDelegate.swift            # App delegate
│   └── SceneDelegate.swift          # Scene delegate
│
├── Common/                           # Shared components
│   ├── Managers/                    # Business services
│   │   ├── DataManager.swift       # Data persistence
│   │   ├── NotificationManager.swift
│   │   └── TipsSearchManager.swift
│   └── Views/                       # Reusable UI components
│       ├── ScheduleCell.swift
│       └── TipCell.swift
│
├── Entities/                         # Domain models
│   ├── WateringSchedule.swift
│   └── PlantTip.swift
│
└── Modules/                          # Feature modules (VIPER)
    ├── Schedule/                    # ✅ FULL VIPER (Reference Implementation)
    │   ├── ScheduleContract.swift  # Protocols/Contracts
    │   ├── ScheduleView.swift      # View layer
    │   ├── SchedulePresenter.swift # Presentation logic
    │   ├── ScheduleInteractor.swift # Business logic
    │   └── ScheduleRouter.swift    # Navigation/Routing
    │
    ├── AddSchedule/                # 🔄 TO BE IMPLEMENTED
    │   ├── AddScheduleContract.swift
    │   ├── AddScheduleView.swift
    │   ├── AddSchedulePresenter.swift
    │   ├── AddScheduleInteractor.swift
    │   └── AddScheduleRouter.swift
    │
    ├── Tips/                       # 🔄 TO BE IMPLEMENTED
    │   ├── TipsContract.swift
    │   ├── TipsView.swift
    │   ├── TipsPresenter.swift
    │   ├── TipsInteractor.swift
    │   └── TipsRouter.swift
    │
    └── TipDetail/                  # 🔄 TO BE IMPLEMENTED
        ├── TipDetailContract.swift
        ├── TipDetailView.swift
        ├── TipDetailPresenter.swift
        ├── TipDetailInteractor.swift
        └── TipDetailRouter.swift
```

## 🎯 VIPER Layer Responsibilities

### 1. **VIEW** (UIViewController)
- **Responsibility:** Display data & handle user interactions
- **Does:**
  - Manage UI components
  - Receive user input
  - Show data from Presenter
- **Does NOT:**
  - Contain business logic
  - Make navigation decisions
  - Access data directly

**Example:**
```swift
class ScheduleView: UIViewController, ScheduleViewProtocol {
    var presenter: SchedulePresenterProtocol?

    func showSchedules(_ schedules: [WateringSchedule]) {
        // Update UI
    }

    @objc private func addTapped() {
        presenter?.didTapAddSchedule() // Delegate to presenter
    }
}
```

### 2. **INTERACTOR** (Business Logic)
- **Responsibility:** Execute business logic
- **Does:**
  - Fetch/save data
  - Apply business rules
  - Use services (DataManager, etc)
- **Does NOT:**
  - Know about UI
  - Handle navigation
  - Format data for display

**Example:**
```swift
class ScheduleInteractor: ScheduleInteractorProtocol {
    weak var presenter: ScheduleInteractorOutputProtocol?
    private let dataManager = DataManager.shared

    func fetchSchedules() {
        let schedules = dataManager.loadSchedules()
        presenter?.didFetchSchedules(schedules)
    }
}
```

### 3. **PRESENTER** (Coordinator)
- **Responsibility:** Coordinate between View & Interactor
- **Does:**
  - Handle user actions from View
  - Request data from Interactor
  - Format data for View
  - Trigger navigation via Router
- **Does NOT:**
  - Contain business logic
  - Access services directly
  - Manage UI components

**Example:**
```swift
class SchedulePresenter: SchedulePresenterProtocol {
    weak var view: ScheduleViewProtocol?
    var interactor: ScheduleInteractorProtocol?
    var router: ScheduleRouterProtocol?

    func viewDidLoad() {
        interactor?.fetchSchedules()
    }

    func didTapAddSchedule() {
        router?.navigateToAddSchedule(from: view)
    }
}
```

### 4. **ENTITY** (Data Models)
- **Responsibility:** Represent domain data
- **Does:**
  - Define data structures
  - Codable for persistence
- **Does NOT:**
  - Contain business logic
  - Know about other layers

**Example:**
```swift
struct WateringSchedule: Codable {
    let id: UUID
    var plantName: String
    var wateringTime: Date
    var isEnabled: Bool
}
```

### 5. **ROUTER** (Navigation)
- **Responsibility:** Handle navigation between modules
- **Does:**
  - Create module instances
  - Wire dependencies (Dependency Injection)
  - Navigate between screens
- **Does NOT:**
  - Contain business logic
  - Access data
  - Manage UI

**Example:**
```swift
class ScheduleRouter: ScheduleRouterProtocol {
    static func createModule() -> UIViewController {
        let view = ScheduleView()
        let presenter = SchedulePresenter()
        let interactor = ScheduleInteractor()
        let router = ScheduleRouter()

        // Dependency Injection
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return view
    }

    func navigateToAddSchedule(from view: ScheduleViewProtocol?) {
        // Navigation logic
    }
}
```

## 🔄 Data Flow Example

**User taps "Add Schedule" button:**

```
1. VIEW receives tap
   ↓
2. VIEW calls presenter.didTapAddSchedule()
   ↓
3. PRESENTER asks router to navigate
   ↓
4. ROUTER creates AddSchedule module & presents it
```

**App loads schedules:**

```
1. VIEW calls presenter.viewDidLoad()
   ↓
2. PRESENTER calls interactor.fetchSchedules()
   ↓
3. INTERACTOR fetches from DataManager
   ↓
4. INTERACTOR calls presenter.didFetchSchedules(schedules)
   ↓
5. PRESENTER formats data & calls view.showSchedules()
   ↓
6. VIEW updates UI with schedules
```

## 🎨 Benefits of VIPER

### ✅ **Testability**
- Each layer can be tested independently
- Easy to mock dependencies
- Clear interfaces (protocols)

### ✅ **Separation of Concerns**
- Each layer has single responsibility
- Clear boundaries between layers
- Easy to understand and maintain

### ✅ **Scalability**
- Easy to add new features (new modules)
- Reusable components
- Clear project structure

### ✅ **Team Collaboration**
- Developers can work on different modules
- Clear ownership of components
- Reduced merge conflicts

## 📝 How to Create New Module

### Step 1: Create Module Folder
```bash
mkdir -p CabeCare/Modules/NewFeature
```

### Step 2: Create Contract (Protocols)
```swift
// NewFeatureContract.swift
protocol NewFeatureViewProtocol: AnyObject {
    var presenter: NewFeaturePresenterProtocol? { get set }
}

protocol NewFeaturePresenterProtocol: AnyObject {
    var view: NewFeatureViewProtocol? { get set }
    var interactor: NewFeatureInteractorProtocol? { get set }
    var router: NewFeatureRouterProtocol? { get set }
}

protocol NewFeatureInteractorProtocol: AnyObject {
    var presenter: NewFeatureInteractorOutputProtocol? { get set }
}

protocol NewFeatureInteractorOutputProtocol: AnyObject {
}

protocol NewFeatureRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}
```

### Step 3: Implement Each Layer
- Create View (UIViewController)
- Create Presenter
- Create Interactor
- Create Router
- Wire dependencies in Router.createModule()

### Step 4: Use Module
```swift
let newFeatureVC = NewFeatureRouter.createModule()
navigationController?.pushViewController(newFeatureVC, animated: true)
```

## 🔍 Reference Implementation

**Schedule Module** adalah implementasi lengkap VIPER yang bisa dijadikan referensi:
- `CabeCare/Modules/Schedule/`

Gunakan sebagai template untuk membuat module lain.

## 📚 Further Reading

- [VIPER Architecture by objc.io](https://www.objc.io/issues/13-architecture/viper/)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [iOS VIPER Tutorial](https://www.raywenderlich.com/8440907-getting-started-with-the-viper-architecture-pattern)

---

**Dibuat dengan ❤️ untuk CabeCare iOS App**
