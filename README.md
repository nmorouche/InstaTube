# 📸 InstaTube

**InstaTube** is a modern mobile application that merges the immersive *Story* experience of Instagram with the engaging vertical video content of *YouTube Shorts* and *TikTok*.
Powered by the [InstaTube API](https://github.com/nmorouche/InstaTube-api), InstaTube provides a seamless, dynamic, and interactive way to explore short-form media content.

---

## 🚀 Features

- 🎞️ **Stories View**  
  - An horizontal scrollable list of users, each with their own stories.
  - Stories update their visual state (red ➜ gray) once viewed.
  - Tapping on a user shows their story (video or image) in full-screen mode.

- 📹 **Shorts Player**  
  - A vertical feed of videos similar to YouTube Shorts or TikTok.
  - Infinite scroll for discovering short, snackable video content.

- ❤️ **Likes & Interaction**
  - Stories and Shorts can be liked.
  - Visual feedback when a like is added.
  - Likes trigger a network call to register the action.
  - When a story is seen, it triggers a network call to register the action.

---

## 🧠 Architecture

The application follows the **MVVM (Model-View-ViewModel)** architecture pattern for a clean separation of concerns, enhanced testability, and maintainability.

- **Model**: Handles data models and responses from the API.
- **View**: Displays the UI using reactive bindings to the ViewModel.
- **ViewModel**: Contains UI logic and state management, communicating with the NetworkLayer.

---

## 🧩 Key Technical Components

### 🔧 Dependency Injection (DI)
- Custom-built DI package for managing dependencies cleanly and efficiently.
- Promotes scalability and testability.
- Centralized service locator for shared resources.

### 🌐 Network Layer
- Fully modular and scalable HTTP client layer.
- Handles all API calls including:
  - Fetching users and their stories.
  - Fetching Shorts video feed.
  - Sending likes and interaction data.
- Supports easy expansion to include additional endpoints or data models.

---
