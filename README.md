# InstaStories

Loom
https://www.loom.com/share/2ce652811c694d708f8b7a0349bd78e9?sid=6bd6975e-657d-46a9-9d01-01aef8a51668

**InstaStories** is a local-first, Instagram-inspired application focused primarily on the **Story feature**. Built with an MVVM architecture, this app allows users view, and like stories.

---

## 🏗️ Architectural Decisions

### MVVM Pattern

The application is structured using the **Model-View-ViewModel (MVVM)** architecture:

- **Model**: Handles business logic and local data persistence (e.g., using CoreData or SwiftData for storage).
- **View**: Displays story content and reacts to user input via data binding.
- **ViewModel**: Acts as an intermediary between Model and View, exposing observable data and handling UI-related logic.

This separation of concerns makes the app more maintainable, testable, and scalable.

### Offline-First Design

- **Local Storage**: All data (including stories, user info, and media) should be stored locally. The app does not depend on any external APIs, it is fully offline.
- **Lifecycle-Aware**: Observers are lifecycle-aware, ensuring proper resource management and a responsive UI even during configuration changes.

---

## ⚠️ Assumptions & Limitations

- **No Internet**: The app is designed to work **fully offline**. There are no network requests.
- **Single Device**: Stories are only available on the device where they were created. No cross-device sync or account system.
- **Limited Feature Scope**: 
  - No main feed, or messaging.
  - Focused solely on consumption of stories.
- **No User Authentication**: As it's offline, there's no login or multi-user support.

