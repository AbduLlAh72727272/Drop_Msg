import 'package:flutter/material.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, registering }

class AuthProvider with ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  String? _userId;
  String? _phoneNumber;
  String? _userName;
  String? _userImage;
  String? _pendingPhoneNumber;
  String? _pendingCountryCode;
  bool _isNewUser = false;

  AuthStatus get status => _status;
  String? get userId => _userId;
  String? get phoneNumber => _phoneNumber;
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get pendingPhoneNumber => _pendingPhoneNumber;
  String? get pendingCountryCode => _pendingCountryCode;
  bool get isNewUser => _isNewUser;

  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isRegistering => _status == AuthStatus.registering;

  Future<void> checkAuthStatus() async {
    _status = AuthStatus.loading;
    notifyListeners();

    // Simulate auth check
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, always return unauthenticated
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<bool> signInWithPhone(String phoneNumber, String countryCode) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Simulate OTP sending
      await Future.delayed(const Duration(seconds: 2));
      
      // Store pending phone number for verification
      _pendingPhoneNumber = phoneNumber;
      _pendingCountryCode = countryCode;
      
      // DUMMY NUMBERS FOR TESTING:
      // Define specific test numbers that always work
      List<String> dummyNumbers = [
        '1234567890',  // Always works as NEW USER
        '9876543210',  // Always works as EXISTING USER  
        '5555555555',  // Always works as NEW USER
        '1111111111',  // Always works as EXISTING USER
        '0000000000',  // Always works as NEW USER
      ];
      
      // Check if entered number is a dummy number
      if (dummyNumbers.contains(phoneNumber)) {
        // Determine if new or existing user based on number
        _isNewUser = ['1234567890', '5555555555', '0000000000'].contains(phoneNumber);
        return true;
      } else {
        // For any other number, also allow but make them new users
        _isNewUser = true;
        return true;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithBiometric() async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Simulate biometric authentication
      await Future.delayed(const Duration(seconds: 1));
      
      // For demo purposes, always succeed
      _status = AuthStatus.authenticated;
      _userId = 'demo_user_bio_123';
      _phoneNumber = '+1234567890';
      _userName = 'Biometric User';
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOTP(String otp) async {
    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Simulate OTP verification
      await Future.delayed(const Duration(seconds: 2));
      
      // DUMMY OTP CODES FOR TESTING:
      // Accept specific test codes or any 6-digit code
      List<String> dummyOTPs = [
        '123456',  // Always works
        '000000',  // Always works
        '111111',  // Always works
        '999999',  // Always works
        '555555',  // Always works
      ];
      
      // Accept dummy codes or any 6-digit OTP for testing
      if (dummyOTPs.contains(otp) || (otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp))) {
        if (_isNewUser) {
          // New user needs to complete registration
          _status = AuthStatus.registering;
          _userId = 'new_user_${DateTime.now().millisecondsSinceEpoch}';
          _phoneNumber = '$_pendingCountryCode$_pendingPhoneNumber';
          _userName = null; // Will be set during profile setup
        } else {
          // Existing user, sign them in directly
          _status = AuthStatus.authenticated;
          _userId = 'existing_user_${DateTime.now().millisecondsSinceEpoch}';
          _phoneNumber = '$_pendingCountryCode$_pendingPhoneNumber';
          _userName = 'Demo User';
          _userImage = 'assets/icons/default_avatar.png';
        }
        notifyListeners();
        return true;
      } else {
        _status = AuthStatus.unauthenticated;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeRegistration({
    required String name,
    String? image,
    Map<String, dynamic>? preferences,
  }) async {
    if (_status != AuthStatus.registering) {
      return false;
    }

    _status = AuthStatus.loading;
    notifyListeners();

    try {
      // Simulate registration completion
      await Future.delayed(const Duration(seconds: 2));
      
      _userName = name;
      _userImage = image ?? 'assets/icons/default_avatar.png';
      _status = AuthStatus.authenticated;
      
      // Save preferences if provided
      if (preferences != null) {
        // In a real app, you'd save these to a database or storage
        // For now, just log them
        print('User preferences saved: $preferences');
      }
      
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.registering;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _status = AuthStatus.loading;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _status = AuthStatus.unauthenticated;
    _userId = null;
    _phoneNumber = null;
    _userName = null;
    _userImage = null;
    _pendingPhoneNumber = null;
    _pendingCountryCode = null;
    _isNewUser = false;
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? image,
  }) async {
    if (name != null) _userName = name;
    if (image != null) _userImage = image;
    notifyListeners();
  }
}