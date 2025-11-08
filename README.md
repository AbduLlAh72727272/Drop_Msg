# DropMsg - Next-Level Messaging App 🚀

A futuristic messaging application that redefines communication with advanced features, stunning UI/UX, and cutting-edge technology. Built with Flutter and powered by Firebase.

![DropMsg Logo](assets/images/drop_logo.png)

## ✨ Features

### 🎨 **Futuristic UI/UX**
- **Iridescent Metallics & Aqua** color scheme
- **Glassmorphism** effects throughout the app
- **Smooth animations** with Flutter Animate
- **Responsive design** that adapts to all screen sizes
- **Light and Dark themes** with seamless switching
- **Next-level visual effects** and micro-interactions

### 🔐 **Advanced Authentication**
- **Phone number authentication** with Firebase Auth
- **OTP verification** with beautiful PIN input
- **Biometric authentication** support
- **Multi-device sync** capabilities

### 💬 **Enhanced Messaging**
- **Real-time messaging** with Firebase Firestore
- **End-to-end encryption** for maximum security
- **Rich media support** (images, videos, audio, documents)
- **Voice messages** with advanced audio controls
- **Reply and forward** functionality
- **Message reactions** and emoji support
- **Disappearing messages** with custom timers

### 🤖 **AI-Powered Features**
- **Smart replies** powered by machine learning
- **Real-time language translation** (10+ languages)
- **Mood detection** and sentiment analysis
- **Voice assistant** integration
- **Message suggestions** based on context
- **Spam detection** and filtering

### 📱 **Status & Stories**
- **Instagram-like stories** with advanced editing
- **Photo and video status** updates
- **Privacy controls** for status viewing
- **Status reactions** and replies
- **24-hour auto-deletion**

### 📞 **Advanced Calling**
- **High-quality voice calls** with noise cancellation
- **4K video calls** with beauty filters
- **Group video calls** (up to 50 participants)
- **Screen sharing** capabilities
- **Call recording** with privacy controls
- **Background blur** and virtual backgrounds

### 🌟 **Premium Features**
- **AR stickers** and effects
- **Holographic messages** (future feature)
- **Quantum encryption** for enterprise users
- **Cloud backup** with advanced sync
- **Custom themes** and personalization
- **Priority message delivery**

### 🛡️ **Security & Privacy**
- **End-to-end encryption** for all communications
- **Disappearing messages** with various timers
- **Screenshot detection** and blocking
- **Two-factor authentication** (2FA)
- **Privacy mode** with app lock
- **Secure file sharing** with virus scanning

### 🌐 **Cross-Platform**
- **iOS, Android, Web** support
- **Desktop apps** (Windows, macOS, Linux)
- **Seamless synchronization** across all devices
- **Cloud storage integration**

## 🚀 Technology Stack

- **Frontend**: Flutter 3.9+
- **Backend**: Firebase (Firestore, Auth, Storage, Messaging)
- **Real-time Communication**: Socket.IO
- **Authentication**: Firebase Auth with custom OTP
- **Database**: Cloud Firestore + local Hive storage
- **Media Processing**: FFmpeg, Image compression
- **AI/ML**: TensorFlow Lite, Google ML Kit
- **Push Notifications**: Firebase Cloud Messaging
- **Analytics**: Firebase Analytics

## 📱 Screenshots

### Authentication Flow
- Splash screen with animated logo
- Beautiful onboarding with glassmorphic cards
- Phone authentication with country picker
- OTP verification with PIN input

### Main Interface
- Tabbed interface (Chats, Status, Calls, AI)
- Glassmorphic chat bubbles
- Floating action button with animations
- Advanced search and filtering

### Chat Features
- Rich text formatting
- Media sharing with previews
- Voice message waveforms
- Message reactions and replies

## 🛠️ Installation & Setup

### Prerequisites
- Flutter 3.9 or later
- Dart 3.0 or later
- Firebase project setup
- iOS/Android development environment

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/dropmsg.git
cd dropmsg
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Setup
1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
2. Enable the following services:
   - Authentication (Phone)
   - Firestore Database
   - Cloud Storage
   - Cloud Messaging
3. Download configuration files:
   - `google-services.json` for Android (place in `android/app/`)
   - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)

### 4. Android Setup
Add the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.VIBRATE" />
```

### 5. iOS Setup
Add the following to `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs access to camera to take photos and videos.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app needs access to microphone to record audio messages.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to share images.</string>
```

### 6. Run the App
```bash
# For development
flutter run

# For release
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 🎨 Design System

### Color Palette
- **Primary Aqua**: `#00FFFF`
- **Secondary Aqua**: `#40E0D0`
- **Tertiary Aqua**: `#7FFFD4`
- **Metallic Silver**: `#B8860B`
- **Metallic Gold**: `#FFD700`
- **Metallic Copper**: `#B87333`

### Typography
- **Primary Font**: Orbitron (futuristic headers)
- **Secondary Font**: Poppins (body text)
- **Weights**: Light (300), Regular (400), Medium (500), SemiBold (600), Bold (700)

### Components
- **Glassmorphic containers** with blur effects
- **Gradient buttons** with hover animations
- **Custom input fields** with floating labels
- **Animated icons** and transitions

## 📚 Project Structure

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── router/            # Navigation logic
│   └── theme/             # Theme and styling
├── features/              # Feature-based modules
│   ├── auth/             # Authentication
│   ├── chat/             # Chat functionality
│   ├── home/             # Main dashboard
│   ├── profile/          # User profile
│   ├── splash/           # Splash screen
│   └── onboarding/       # User onboarding
├── shared/               # Shared components
│   ├── providers/        # State management
│   ├── services/         # External services
│   └── widgets/          # Reusable widgets
└── main.dart            # App entry point
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
```

### Features Toggle
Configure features in `lib/core/constants/app_constants.dart`:
```dart
class FeatureFlags {
  static const bool enableAIFeatures = true;
  static const bool enableVideoCall = true;
  static const bool enableDisappearingMessages = true;
  static const bool enableVoiceMessages = true;
}
```

## 🧪 Testing

Run tests with:
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget_test.dart
```

## 🚀 Performance Optimization

- **Lazy loading** for chat messages
- **Image compression** and caching
- **Background sync** for offline support
- **Memory management** for media files
- **Network optimization** with retry logic

## 🔒 Security Features

- **AES-256 encryption** for local data
- **TLS 1.3** for network communication
- **Certificate pinning** for API calls
- **Biometric authentication** support
- **Secure key storage** with platform APIs

## 📱 Platform Support

| Platform | Status | Features |
|----------|--------|----------|
| Android | ✅ Full Support | All features |
| iOS | ✅ Full Support | All features |
| Web | 🔄 In Progress | Core features |
| Windows | 🔄 Planned | Desktop optimized |
| macOS | 🔄 Planned | Desktop optimized |
| Linux | 🔄 Planned | Desktop optimized |

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google Fonts for typography
- Unsplash for placeholder images
- The open-source community

## 📞 Support

For support and questions:
- Email: support@dropmsg.com
- Discord: [DropMsg Community](https://discord.gg/dropmsg)
- Twitter: [@DropMsgApp](https://twitter.com/dropmsgapp)

---

**Made with ❤️ and cutting-edge technology**

*DropMsg - Where the future of messaging begins*
#   D r o p _ M s g  
 