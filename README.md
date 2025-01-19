
<div align="center">
<img width="100" height="100" src="https://github.com/user-attachments/assets/b96bc281-87e7-4f51-b5c4-26ee50dab0e2">
</div>


# VidApp

A Flutter-based video feed application that offers seamless video playback, comment functionality, user authentication, and various other exciting features. This app is designed to provide users with an engaging and intuitive video browsing experience.

## ✨ Features

### Library & Indexing
- A well-structured video library with easy indexing.
- Users can browse through a list of videos seamlessly.

### Look & Feel
- Intuitive user interface designed with Flutter.
- Smooth navigation and vibrant themes for an enhanced user experience.

### Streaming & Video Playback
- Integrated `video_player` package for seamless video playback.
- Offline video sharing using `share_plus`.

### User Authentication
- Registration and login functionality using Firebase Authentication with email/password.
- Successful login redirects users to the homepage.

### Video Feed
- Displays a list of more than 20 static video links in a vertically scrollable feed.
- Each video covers the screen and plays when in focus, ensuring only one video plays at a time.

### UI Elements
- Each video displays:
  - A Comment button that opens the comments page for the respective video.
  - A Share button that opens the system’s share dialog with the video link.

### Comment Feature
- **Comment Page**: Opens a new page/modal for the video when the Comment button is clicked, allowing users to type and send comments.

#### Bot Interaction
- If the user doesn’t type a new comment within **5 seconds** after sending a comment, a bot automatically posts a random comment. This interaction simulates a lively chat environment and encourages user engagement.
- The bot-generated comments appear on the same video, adding a dynamic element to the comment section.

### Storage and Persistence
- **Local Storage**: Comments (both user and bot) are saved locally using **Hive**, a lightweight and fast key-value database for Flutter. Each comment is tied to its respective video to ensure correct retrieval.
- **Persistence**: When the app is reopened, previously saved comments are retrieved and displayed, ensuring a seamless user experience. This allows users to continue their discussions without losing context from previous sessions.

### Share Feature
- Clicking the Share button opens the native share dialog of the device, sharing the respective video link.

### State Management
- Utilized **BLoC** (Business Logic Component) for managing the app’s state. This approach separates business logic from UI code, making it easier to manage and test.

### UI/UX Considerations
- Designed a clean and user-friendly UI.
- Ensured responsive design to support various screen sizes.
- Light and dark theme support for enhanced user experience.

### Cool Features
- Custom reusable components like buttons, text fields, and dialogs for consistent design.
- Integrated Firebase core functionalities for authentication and storage.

---

## 📁 Folder Structure

Below is the organized folder structure of the project for scalability and maintainability:

```plaintext
lib/
├── components/               # Reusable UI components
│   ├── button/               # Custom button widgets
│   │   └── t_primary_button.dart
│   ├── textfield/            # Custom text field widgets
│   │   └── t_text_field.dart
│   └── utils/                # Utility functions for dialogs, sharing, etc.
│       ├── dialog_utils.dart
│       └── fileshare_utils.dart
├── common/                   # Common utilities and extensions
│   ├── constants/            # Global constants (e.g., StringConstants)
│   ├── extra/                # Reusable screens or widgets
│   │   └── reusable_info_screen.dart
│   ├── extension/            # Extensions for Flutter widgets and classes
│   │   └── text_theme_extension.dart
│   └── utils/                # Common helper methods (e.g., snackbar utils)
│       ├── snackbar_utils.dart
│       └── bottom_sheet_utils.dart
├── features/                 # Main features of the app
│   ├── auth/                 # Authentication-related screens
│   │   ├── screens/          # Login and signup screens
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   └── services/         # Wrapper for authentication
│   │       └── wrapper.dart
│   ├── comment/              # Comment feature
│   │   ├── bloc/             # State management for comments
│   │   │   └── cubit/        # Cubit implementation for comments
│   │   │       └── comments_cubit.dart
│   │   ├── bot/              # Chatbot integration for comments
│   │   │   └── comment_bot.dart
│   │   └── model/            # Comment data models
│   │       └── comment_model.dart
│   └── services/             # General app services (authentication, etc.)
├── home/                     # Home screen and related features
│   ├── screens/              # Screens for various home features
│   │   ├── add_video_screen.dart
│   │   ├── chat_screen.dart
│   │   ├── friends_screen.dart
│   │   ├── home_screen.dart
│   │   └── profile_screen.dart
├── styles/                   # App-wide styles and assets
│   ├── app_assets.dart       # Asset paths and management
│   ├── app_colors.dart       # Centralized color definitions
├── main.dart                 # Entry point of the application
```

---

## 📽 Video Integration
The app uses the following for video integration:

- **Video playback**: Managed using the `video_player` package for efficient rendering.
- **Video storage**: Paths are handled dynamically using `AppAssets`.

---

## 🖼 Screenshots
## Screenshot
<img height="400" src="https://github.com/user-attachments/assets/8e875d87-c9c5-40a6-86c4-6b6ec4ae7887">
<img height="400" src="https://github.com/user-attachments/assets/a49ade44-7ed6-4f45-b4e8-c122974c0931">
<img height="400" src="https://github.com/user-attachments/assets/30e2c5c0-b627-488c-913a-7b4e5a64e57b">
<img height="400" src="https://github.com/user-attachments/assets/0206622a-9fd7-47e9-9fbc-936babc031be">
<img height="400" src="https://github.com/user-attachments/assets/4ef1803a-af09-4e06-9bc3-9c39f26b7e4f">
<img height="400" src="https://github.com/user-attachments/assets/389a012a-e868-4d79-92a0-4856af258058">
<img height="400" src="https://github.com/user-attachments/assets/24cc53f2-fb08-40f0-8393-794c1d7c61da">

---

## 💻 Usage Preview
### [Click Here to Watch Video](https://drive.google.com/drive/folders/1Xd1_BjlkOxlrAnJrGhJW8AjOKkKuiZ2D?usp=sharing)
---

### [Download App Here](https://drive.google.com/drive/folders/10f0-6Cn3JMk2qvbmSWbTWSuOLnub29Ip?usp=drive_link)

---

### [Documentation](https://github.com/user-attachments/files/18468562/VidApp.Documentation.docx)

---

## ⚙️ Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aakashx58/video-feed-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd video-feed-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## 🔒 Permission Note
This app uses permissions for video playback, sharing, and accessing device storage. Make sure to add the required permissions to your `AndroidManifest.xml` and `Info.plist` files.

---

## 🙏 Special Thanks
- Flutter
- Firebase
- Hive
- Video Player
- Contributors and open-source libraries.

---

## 🌐 Social
- join us on our platforms for updates, tips, discussion & ideas
  - [LinkedIn](https://www.linkedin.com/in/aakash569/)
  - [Portfolio](https://aakashrajbanshi.com.np/)
---

## 🧑‍💻A Author

VidApp is Developed by [Aakash](https://aakashrajbanshi.com.np/)
