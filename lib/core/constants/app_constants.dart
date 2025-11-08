class AppConstants {
  // App Information
  static const String appName = 'DropMsg';
  static const String appVersion = '1.0.0';
  
  // API Endpoints
  static const String baseUrl = 'https://api.dropmsg.com';
  static const String wsUrl = 'wss://ws.dropmsg.com';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String chatsCollection = 'chats';
  static const String messagesCollection = 'messages';
  static const String statusCollection = 'status';
  static const String callsCollection = 'calls';
  
  // Storage Paths
  static const String profileImagesPath = 'profile_images';
  static const String chatImagesPath = 'chat_images';
  static const String voiceNotesPath = 'voice_notes';
  static const String documentsPath = 'documents';
  static const String statusImagesPath = 'status_images';
  static const String statusVideosPath = 'status_videos';
  
  // Shared Preferences Keys
  static const String userIdKey = 'user_id';
  static const String phoneNumberKey = 'phone_number';
  static const String isLoggedInKey = 'is_logged_in';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String notificationKey = 'notifications_enabled';
  
  // Animation Durations
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  // Message Types
  static const String textMessage = 'text';
  static const String imageMessage = 'image';
  static const String videoMessage = 'video';
  static const String audioMessage = 'audio';
  static const String documentMessage = 'document';
  static const String locationMessage = 'location';
  static const String contactMessage = 'contact';
  static const String replyMessage = 'reply';
  
  // Call Types
  static const String audioCall = 'audio';
  static const String videoCall = 'video';
  
  // Status Types
  static const String imageStatus = 'image';
  static const String videoStatus = 'video';
  static const String textStatus = 'text';
  
  // File Size Limits (in bytes)
  static const int maxImageSize = 10 * 1024 * 1024; // 10 MB
  static const int maxVideoSize = 100 * 1024 * 1024; // 100 MB
  static const int maxAudioSize = 5 * 1024 * 1024; // 5 MB
  static const int maxDocumentSize = 20 * 1024 * 1024; // 20 MB
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 8.0;
  static const double defaultRadius = 16.0;
  static const double defaultIconSize = 24.0;
  
  // Advanced Features
  static const List<String> supportedLanguages = [
    'en', 'es', 'fr', 'de', 'it', 'pt', 'ru', 'ar', 'hi', 'zh'
  ];
  
  static const List<String> emergencyContacts = [
    '911', '112', '100', '101', '102'
  ];
}