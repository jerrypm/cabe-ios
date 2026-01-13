# CabeCare Development Roadmap

## Project Overview
**App Name:** CabeCare - Aplikasi Perawatan Tanaman Cabe
**Architecture:** VIPER (Clean Architecture)
**Languages:** Swift (iOS 13+)
**Localization:** Indonesian & English
**File Naming Convention:** All files use `CB` prefix

---

## Current Status

### All Modules Using VIPER Architecture
- [x] CBTabBar Module
- [x] CBSchedule Module
- [x] CBSettings Module
- [x] CBTips Module
- [x] CBTipDetail Module
- [x] CBAddSchedule Module

### Phase 1: Foundation - COMPLETED
- [x] Complete VIPER migration for all modules
- [x] Ensure consistent architecture
- [x] All files renamed with CB prefix

---

## Project File Structure

### App Layer
```
App/
├── AppDelegate.swift
└── SceneDelegate.swift
```

### Common Layer
```
Common/
├── Constants/
│   ├── CBAddScheduleLocalizedKeys.swift
│   ├── CBCommonString.swift
│   ├── CBNotificationString.swift
│   ├── CBScheduleConstants.swift
│   ├── CBScheduleLocalizedKeys.swift
│   ├── CBSettingsLocalizedKeys.swift
│   ├── CBTabBarLocalizedKeys.swift
│   ├── CBTipDetailLocalizedKeys.swift
│   ├── CBTipsConstants.swift
│   └── CBTipsLocalizedKeys.swift
├── Extensions/
│   └── CBString+Localization.swift
├── Managers/
│   ├── CBDataManager.swift
│   ├── CBNotificationManager.swift
│   └── CBTipsSearchManager.swift
└── Views/
    ├── CBScheduleCell.swift
    ├── CBTabBarButton.swift
    ├── CBTabBarView.swift
    └── CBTipCell.swift
```

### Entities Layer
```
Entities/
├── CBPlantTip.swift
└── CBWateringSchedule.swift
```

### Modules Layer (VIPER)
```
Modules/
├── Main/
│   └── CBMainRouter.swift
├── TabBar/
│   ├── CBTabBarContract.swift
│   ├── CBTabBarModuleView.swift
│   ├── CBTabBarPresenter.swift
│   ├── CBTabBarInteractor.swift
│   └── CBTabBarRouter.swift
├── Schedule/
│   ├── CBScheduleContract.swift
│   ├── CBScheduleView.swift
│   ├── CBSchedulePresenter.swift
│   ├── CBScheduleInteractor.swift
│   └── CBScheduleRouter.swift
├── AddSchedule/
│   ├── CBAddScheduleContract.swift
│   ├── CBAddScheduleView.swift
│   ├── CBAddSchedulePresenter.swift
│   ├── CBAddScheduleInteractor.swift
│   └── CBAddScheduleRouter.swift
├── Tips/
│   ├── CBTipsContract.swift
│   ├── CBTipsView.swift
│   ├── CBTipsPresenter.swift
│   ├── CBTipsInteractor.swift
│   └── CBTipsRouter.swift
├── TipDetail/
│   ├── CBTipDetailContract.swift
│   ├── CBTipDetailView.swift
│   ├── CBTipDetailPresenter.swift
│   ├── CBTipDetailInteractor.swift
│   └── CBTipDetailRouter.swift
└── Settings/
    ├── CBSettingsContract.swift
    ├── CBSettingsView.swift
    ├── CBSettingsPresenter.swift
    ├── CBSettingsInteractor.swift
    └── CBSettingsRouter.swift
```

---

## Next Development Phases

### Phase 2: UI Refresh
- [ ] Implement Dark Mode
- [ ] Update design system
- [ ] Refresh existing UI components

### Phase 3: Core Features
- [ ] Plant Journal feature
- [ ] Multiple plants collection

### Phase 4: Enhanced Features
- [ ] Weather integration
- [ ] Home Screen Widget

### Phase 5: Advanced Features
- [ ] AI-powered features
- [ ] Community features

---

## Priority: New Entities

| Entity | Description | Status |
|--------|-------------|--------|
| `CBPlantJournal.swift` | Journal/log entries | [ ] |
| `CBPlantProgress.swift` | Growth tracking | [ ] |
| `CBCareHistory.swift` | Care activity history | [ ] |
| `CBWeatherData.swift` | Weather information | [ ] |

---

## Priority: New Managers

| Manager | Description | Status |
|---------|-------------|--------|
| `CBWeatherManager.swift` | OpenWeatherMap API | [ ] |
| `CBImageManager.swift` | Photo handling | [ ] |
| `CBExportManager.swift` | Data export/backup | [ ] |

---

## Priority: New Features

### Easy Features (High Impact)
| Feature | Module | Status |
|---------|--------|--------|
| Plant Journal/Log | CBJournal | [ ] |
| Weather Integration | CBWeather | [ ] |
| Multiple Plants | CBPlantCollection | [ ] |
| Progress Tracker | CBProgress | [ ] |
| Care History | CBHistory | [ ] |

### Medium Features
| Feature | Description | Status |
|---------|-------------|--------|
| Fertilizer Reminder | Additional reminder types | [ ] |
| Dark Mode | Theme support | [ ] |
| Home Screen Widget | Quick view widget | [ ] |
| Plant Health Check | Symptom checklist | [ ] |
| Export/Backup | iCloud sync or file export | [ ] |

---

## UI Design Guidelines

### Color Palette
```
Primary:     #2E7D32 (Forest Green)
Secondary:   #81C784 (Light Green)
Accent:      #FF8F00 (Chili Orange)
Background:  #FAFAFA (Off White)
Surface:     #FFFFFF (White)
Text:        #212121 (Dark Gray)
```

### Design Trends 2025
- Glassmorphism (frosted glass effect)
- Bento Grid Layout
- Large Typography
- Rounded Corners (16-20pt)
- Soft Shadows
- Dark Mode Support

---

## Technical Notes

### Architecture Pattern (VIPER)
```
View (UIViewController)
  ↓ user action
Presenter (formats data, handles UI logic)
  ↓ business request
Interactor (business logic, data operations)
  ↓ data
Entity (data models)

Router: Creates module, handles navigation
```

### File Naming Convention
- All files must have `CB` prefix
- Example: `CBScheduleView.swift`, `CBDataManager.swift`

### Code Rules
- Max 200 lines per file
- One class per file
- Use MARK comments for organization
- Protocol-oriented programming
- Weak references for delegates
- Dependency injection via Routers

---

## Xcode Project Update Instructions

### Files to REMOVE from Xcode (old references):
```
- AddScheduleLocalizedKeys.swift
- CommonString.swift
- NotificationString.swift
- ScheduleConstants.swift
- ScheduleLocalizedKeys.swift
- SettingsLocalizedKeys.swift
- TabBarLocalizedKeys.swift
- TipDetailLocalizedKeys.swift
- TipsConstants.swift
- TipsLocalizedKeys.swift
- String+Localization.swift
- MainRouter.swift
- ScheduleContract.swift, ScheduleView.swift, etc.
- SettingsContract.swift, SettingsView.swift, etc.
- TabBarContract.swift, TabBarView.swift, etc.
- TipsViewController.swift
- TipDetailViewController.swift
- AddScheduleViewController.swift
```

### Files to ADD to Xcode (new CB-prefixed files):
All files listed in the "Project File Structure" section above.

---

## Resources

- [Best Plant Care Apps 2025](https://myplantin.com/blog/best-plant-care-apps)
- [UI/UX Design Trends 2025](https://www.chopdawg.com/ui-ux-design-trends-in-mobile-apps-for-2025/)
- [Plant App UI Inspiration](https://dribbble.com/tags/plant_care_app)

---

*Last Updated: January 13, 2026*
