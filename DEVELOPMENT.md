# DropMsg Development Guide

## Quick Start

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the App**
   ```bash
   flutter run
   ```

## Firebase Setup (Required for full functionality)

### 1. Create Firebase Project
- Go to [Firebase Console](https://console.firebase.google.com)
- Create a new project named "DropMsg"

### 2. Enable Services
- **Authentication**: Enable Phone authentication
- **Firestore Database**: Create in production mode
- **Cloud Storage**: Enable for file uploads
- **Cloud Messaging**: Enable for push notifications

### 3. Add Configuration Files

#### Android
- Download `google-services.json`
- Place in `android/app/google-services.json`

#### iOS  
- Download `GoogleService-Info.plist`
- Place in `ios/Runner/GoogleService-Info.plist`

## Font Setup (Optional but Recommended)

Download these Google Fonts and place in `assets/fonts/`:

### Poppins Family
- Poppins-Light.ttf (300)
- Poppins-Regular.ttf (400)
- Poppins-Medium.ttf (500)
- Poppins-SemiBold.ttf (600)
- Poppins-Bold.ttf (700)

### Orbitron Family
- Orbitron-Regular.ttf (400)
- Orbitron-Bold.ttf (700)

## Development Features

### Current Implementation
- ✅ Futuristic UI with glassmorphism effects
- ✅ Phone authentication flow
- ✅ Profile setup
- ✅ Home screen with tabs (Chats, Status, Calls, AI)
- ✅ Light/Dark theme switching
- ✅ Advanced animations and transitions

### Upcoming Features
- 🔄 Real-time messaging with Firestore
- 🔄 Voice and video calling
- 🔄 AI-powered features
- 🔄 Status/Stories functionality
- 🔄 File and media sharing

## Testing

### Run Tests
```bash
flutter test
```

### Build for Release
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## Architecture

```
lib/
├── core/                 # Core app functionality
│   ├── constants/       # App constants and configuration
│   ├── router/         # Navigation and routing
│   └── theme/          # App theming and styling
├── features/           # Feature-based modules
│   ├── splash/        # Splash screen
│   ├── onboarding/    # User onboarding
│   ├── auth/          # Authentication (Phone + OTP)
│   ├── profile/       # User profile management
│   └── home/          # Main app dashboard
├── shared/            # Shared components
│   ├── providers/     # State management
│   ├── services/      # External services
│   └── widgets/       # Reusable widgets
└── main.dart         # App entry point
```

## Troubleshooting

### Common Issues

1. **Firebase not configured**
   - Ensure you've added the configuration files
   - Check if all required services are enabled

2. **Font not loading**
   - Verify fonts are in the correct directory
   - Check pubspec.yaml font declarations

3. **Build errors**
   - Run `flutter clean` then `flutter pub get`
   - Check Flutter and Dart versions

### Performance Tips

- Use `flutter analyze` to check for issues
- Profile with `flutter run --profile`
- Monitor memory usage for media-heavy features

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

**Happy coding! 🚀**