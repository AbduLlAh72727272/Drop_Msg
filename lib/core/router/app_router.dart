import 'package:flutter/material.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_auth_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/profile/presentation/screens/profile_setup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String phoneAuth = '/phone-auth';
  static const String otpVerification = '/otp-verification';
  static const String profileSetup = '/profile-setup';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String chatInfo = '/chat-info';
  static const String newChat = '/new-chat';
  static const String status = '/status';
  static const String statusView = '/status-view';
  static const String calls = '/calls';
  static const String callScreen = '/call-screen';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String privacy = '/privacy';
  static const String notifications = '/notifications';
  static const String storage = '/storage';
  static const String about = '/about';
  static const String help = '/help';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _buildRoute(const SplashScreen(), settings);
      case onboarding:
        return _buildRoute(const OnboardingScreen(), settings);
      case auth:
        return _buildRoute(const AuthScreen(), settings);
      case phoneAuth:
        return _buildRoute(const PhoneAuthScreen(), settings);
      case otpVerification:
        return _buildRoute(
          OtpVerificationScreen(phoneNumber: settings.arguments as String),
          settings,
        );
      case profileSetup:
        return _buildRoute(const ProfileSetupScreen(), settings);
      case home:
        return _buildRoute(const HomeScreen(), settings);
      case chat:
        return _buildRoute(
          ChatScreen(chatData: settings.arguments as Map<String, dynamic>),
          settings,
        );
      case chatInfo:
        return _buildRoute(
          ChatInfoScreen(chatData: settings.arguments as Map<String, dynamic>),
          settings,
        );
      case newChat:
        return _buildRoute(const NewChatScreen(), settings);
      case status:
        return _buildRoute(const StatusScreen(), settings);
      case statusView:
        return _buildRoute(
          StatusViewScreen(statusData: settings.arguments as Map<String, dynamic>),
          settings,
        );
      case calls:
        return _buildRoute(const CallsScreen(), settings);
      case callScreen:
        return _buildRoute(
          CallScreen(callData: settings.arguments as Map<String, dynamic>),
          settings,
        );
      case settings:
        return _buildRoute(const SettingsScreen(), settings);
      case profile:
        return _buildRoute(const ProfileScreen(), settings);
      case privacy:
        return _buildRoute(const PrivacyScreen(), settings);
      case notifications:
        return _buildRoute(const NotificationsScreen(), settings);
      case storage:
        return _buildRoute(const StorageScreen(), settings);
      case about:
        return _buildRoute(const AboutScreen(), settings);
      case help:
        return _buildRoute(const HelpScreen(), settings);
      default:
        return _buildRoute(const NotFoundScreen(), settings);
    }
  }
  
  static PageRoute _buildRoute(Widget child, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, _) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

// Placeholder screens - these will be implemented
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Onboarding')));
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Auth')));
}

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Phone Auth')));
}

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  Widget build(BuildContext context) => Scaffold(body: Center(child: Text('OTP for $phoneNumber')));
}

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile Setup')));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Home')));
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatData});
  final Map<String, dynamic> chatData;
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Chat')));
}

class ChatInfoScreen extends StatelessWidget {
  const ChatInfoScreen({super.key, required this.chatData});
  final Map<String, dynamic> chatData;
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Chat Info')));
}

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('New Chat')));
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Status')));
}

class StatusViewScreen extends StatelessWidget {
  const StatusViewScreen({super.key, required this.statusData});
  final Map<String, dynamic> statusData;
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Status View')));
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Calls')));
}

class CallScreen extends StatelessWidget {
  const CallScreen({super.key, required this.callData});
  final Map<String, dynamic> callData;
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Call Screen')));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Settings')));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile')));
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Privacy')));
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Notifications')));
}

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Storage')));
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('About')));
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Help')));
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Page Not Found')));
}