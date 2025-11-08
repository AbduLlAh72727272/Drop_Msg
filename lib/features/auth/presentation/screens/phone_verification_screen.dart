import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pinput/pinput.dart';

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../../shared/widgets/debug_info_widget.dart';
import '../../../home/presentation/screens/futuristic_home_screen.dart';
import '../../../profile/presentation/screens/profile_setup_screen.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _formController;
  late AnimationController _particleController;
  late AnimationController _scanController;

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _otpFocus = FocusNode();

  Country _selectedCountry = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 1,
    geographic: true,
    level: 1,
    name: 'United States',
    example: '2012561234',
    displayName: 'United States (US) [+1]',
    displayNameNoCountryCode: 'United States (US)',
    e164Key: '1-US-0',
  );

  bool _isOTPStep = false;
  bool _isLoading = false;
  bool _canResend = false;
  int _resendTimer = 30;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _formController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _scanController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _formController.forward();
    _checkBiometricAvailability();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _formController.dispose();
    _particleController.dispose();
    _scanController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _phoneFocus.dispose();
    _otpFocus.dispose();
    super.dispose();
  }

  Future<void> _checkBiometricAvailability() async {
    // Simulate biometric check
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _isBiometricAvailable = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, AuthProvider>(
      builder: (context, themeProvider, authProvider, child) {
        final isDarkMode = themeProvider.isDarkMode;
        
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDarkMode
                    ? [
                        const Color(0xFF0A0B0F),
                        const Color(0xFF1A1B2E),
                        const Color(0xFF16213E),
                        const Color(0xFF0E4B99),
                      ]
                    : [
                        const Color(0xFFF8FAFC),
                        const Color(0xFFE1F5FE),
                        const Color(0xFFB3E5FC),
                        const Color(0xFF81D4FA),
                      ],
              ),
            ),
            child: Stack(
              children: [
                // Quantum particles background
                _buildQuantumParticles(isDarkMode),
                
                // Security scanner effect
                _buildSecurityScanner(isDarkMode),
                
                // Debug info widget (for testing)
                const DebugInfoWidget(),
                
                // Main content
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          SizedBox(height: 40.h),
                          
                          // Header with back button
                          _buildHeader(isDarkMode),
                          
                          SizedBox(height: 60.h),
                          
                          // Main form card
                          _buildMainCard(isDarkMode, authProvider),
                          
                          SizedBox(height: 40.h),
                          
                          // Security features
                          _buildSecurityFeatures(isDarkMode),
                          
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Floating security indicators
                _buildFloatingIndicators(isDarkMode),
                
                // Loading overlay
                if (_isLoading) _buildLoadingOverlay(isDarkMode),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantumParticles(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(25, (index) {
            final angle = (index / 25) * 2 * 3.14159;
            final radius = 100 + (index * 15);
            final speed = 0.4 + (index % 3) * 0.2;
            final time = _particleController.value * speed;
            
            final x = MediaQuery.of(context).size.width / 2 + 
                     radius * math.cos(time + angle) * 0.6;
            final y = MediaQuery.of(context).size.height / 2 + 
                     radius * math.sin(time + angle) * 0.4;
            
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 3 + (index % 2),
                height: 3 + (index % 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: [
                    const Color(0xFF00FFFF),
                    const Color(0xFF4ECDC4),
                    const Color(0xFFFFD700),
                  ][index % 3].withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: [
                        const Color(0xFF00FFFF),
                        const Color(0xFF4ECDC4),
                        const Color(0xFFFFD700),
                      ][index % 3].withOpacity(0.3),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildSecurityScanner(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _scanController,
      builder: (context, child) {
        return Positioned.fill(
          child: CustomPaint(
            painter: SecurityScannerPainter(_scanController.value, isDarkMode),
          ),
        );
      },
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00FFFF).withOpacity(0.2),
              border: Border.all(
                color: const Color(0xFF00FFFF).withOpacity(0.5),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: const Color(0xFF00FFFF),
              size: 20.sp,
            ),
          ),
        ),
        
        Expanded(
          child: Column(
            children: [
              Text(
                'SECURE AUTHENTICATION',
                style: GoogleFonts.orbitron(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : const Color(0xFF1A1B2E),
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Quantum-encrypted verification',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: const Color(0xFF00FFFF),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(width: 50.w), // Balance the layout
      ],
    ).animate().slideY(begin: -1, end: 0, duration: 800.ms);
  }

  Widget _buildMainCard(bool isDarkMode, AuthProvider authProvider) {
    return AnimatedBuilder(
      animation: _formController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.8 + (_formController.value * 0.2),
          child: Opacity(
            opacity: _formController.value,
            child: GlassmorphicContainer(
              width: double.infinity,
              height: _isOTPStep ? 500.h : 400.h,
              borderRadius: 30,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: LinearGradient(
                colors: [
                  const Color(0xFF00FFFF).withOpacity(0.5),
                  const Color(0xFF4ECDC4).withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: _isOTPStep 
                    ? _buildOTPForm(isDarkMode, authProvider)
                    : _buildPhoneForm(isDarkMode, authProvider),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneForm(bool isDarkMode, AuthProvider authProvider) {
    return Column(
      children: [
        // Title with holographic effect
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4), Color(0xFFFFD700)],
          ).createShader(bounds),
          child: Text(
            'PHONE VERIFICATION',
            style: GoogleFonts.orbitron(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        Text(
          'Enter your phone number to receive a quantum-encrypted verification code',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: isDarkMode 
                ? Colors.white.withOpacity(0.8)
                : const Color(0xFF1A1B2E).withOpacity(0.8),
            height: 1.5,
          ),
        ),
        
        SizedBox(height: 40.h),
        
        // Country and phone input
        _buildPhoneInput(isDarkMode),
        
        SizedBox(height: 40.h),
        
        // Continue button
        _buildActionButton(
          text: 'SEND VERIFICATION CODE',
          onPressed: () => _sendOTP(authProvider),
          isDarkMode: isDarkMode,
          gradient: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
        ),
        
        SizedBox(height: 20.h),
        
        // Biometric option
        if (_isBiometricAvailable) _buildBiometricOption(isDarkMode),
      ],
    );
  }

  Widget _buildOTPForm(bool isDarkMode, AuthProvider authProvider) {
    return Column(
      children: [
        // Title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4), Color(0xFFFFD700)],
          ).createShader(bounds),
          child: Text(
            'ENTER VERIFICATION CODE',
            style: GoogleFonts.orbitron(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        Text(
          'We sent a 6-digit quantum-encrypted code to\n+${_selectedCountry.phoneCode} ${_phoneController.text}',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: isDarkMode 
                ? Colors.white.withOpacity(0.8)
                : const Color(0xFF1A1B2E).withOpacity(0.8),
            height: 1.5,
          ),
        ),
        
        SizedBox(height: 40.h),
        
        // OTP input
        _buildOTPInput(isDarkMode),
        
        SizedBox(height: 30.h),
        
        // Resend timer or button
        _buildResendSection(isDarkMode, authProvider),
        
        SizedBox(height: 40.h),
        
        // Verify button
        _buildActionButton(
          text: 'VERIFY & CONTINUE',
          onPressed: () => _verifyOTP(authProvider),
          isDarkMode: isDarkMode,
          gradient: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
        ),
        
        SizedBox(height: 20.h),
        
        // Change number
        GestureDetector(
          onTap: () => _changePhoneNumber(),
          child: Text(
            'Change phone number',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: Color(0xFF00FFFF),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF00FFFF).withOpacity(0.3),
        ),
        color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.05),
      ),
      child: Row(
        children: [
          // Country picker
          GestureDetector(
            onTap: _showCountryPicker,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _selectedCountry.flagEmoji,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '+${_selectedCountry.phoneCode}',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF00FFFF),
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
          
          // Separator
          Container(
            width: 1,
            height: 30.h,
            color: Color(0xFF00FFFF).withOpacity(0.3),
          ),
          
          // Phone input
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocus,
              keyboardType: TextInputType.phone,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Phone number',
                hintStyle: GoogleFonts.poppins(
                  color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.5),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPInput(bool isDarkMode) {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: GoogleFonts.orbitron(
        fontSize: 20.sp,
        color: isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF00FFFF).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(15),
        color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.05),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color(0xFF00FFFF)),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF00FFFF).withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 2,
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color(0xFF00FFFF).withOpacity(0.1),
        border: Border.all(color: Color(0xFF4ECDC4)),
      ),
    );

    return Pinput(
      controller: _otpController,
      focusNode: _otpFocus,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => _verifyOTP(Provider.of<AuthProvider>(context, listen: false)),
    );
  }

  Widget _buildResendSection(bool isDarkMode, AuthProvider authProvider) {
    if (_canResend) {
      return GestureDetector(
        onTap: () => _resendOTP(authProvider),
        child: Text(
          'Resend verification code',
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Color(0xFF00FFFF),
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return Text(
        'Resend code in $_resendTimer seconds',
        style: GoogleFonts.poppins(
          fontSize: 14.sp,
          color: isDarkMode 
              ? Colors.white.withOpacity(0.6)
              : Colors.black.withOpacity(0.6),
        ),
      );
    }
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required bool isDarkMode,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: gradient),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.orbitron(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        ),
      ).animate().scale(duration: 200.ms),
    );
  }

  Widget _buildBiometricOption(bool isDarkMode) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'OR',
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
          ],
        ),
        
        SizedBox(height: 20.h),
        
        GestureDetector(
          onTap: _authenticateWithBiometric,
          child: Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
              ),
            ),
            child: Icon(
              Icons.fingerprint,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Text(
          'Use biometric authentication',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityFeatures(bool isDarkMode) {
    final features = [
      {'icon': Icons.security, 'text': 'Quantum Encryption'},
      {'icon': Icons.verified_user, 'text': 'Zero-Knowledge Protocol'},
      {'icon': Icons.fingerprint, 'text': 'Biometric Security'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((feature) {
        return Column(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00FFFF).withOpacity(0.2),
                border: Border.all(
                  color: Color(0xFF00FFFF).withOpacity(0.5),
                ),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: Color(0xFF00FFFF),
                size: 24.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              feature['text'] as String,
              style: GoogleFonts.poppins(
                fontSize: 10.sp,
                color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        );
      }).toList(),
    ).animate().slideY(begin: 1, end: 0, duration: 1000.ms, delay: 600.ms);
  }

  Widget _buildFloatingIndicators(bool isDarkMode) {
    return Stack(
      children: [
        Positioned(
          top: 120.h,
          left: 20.w,
          child: _buildFloatingIcon(Icons.shield, Color(0xFF00FFFF), 3000),
        ),
        Positioned(
          top: 200.h,
          right: 30.w,
          child: _buildFloatingIcon(Icons.lock, Color(0xFF4ECDC4), 4000),
        ),
        Positioned(
          bottom: 200.h,
          left: 40.w,
          child: _buildFloatingIcon(Icons.verified, Color(0xFFFFD700), 3500),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, int duration) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Icon(icon, color: color, size: 20.sp),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
      begin: -10,
      end: 10,
      duration: Duration(milliseconds: duration),
    );
  }

  Widget _buildLoadingOverlay(bool isDarkMode) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: GlassmorphicContainer(
          width: 200.w,
          height: 200.w,
          borderRadius: 20,
          blur: 20,
          alignment: Alignment.center,
          border: 2,
          linearGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
          ),
          borderGradient: LinearGradient(
            colors: [
              Color(0xFF00FFFF).withOpacity(0.5),
              Colors.transparent,
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.w,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFF00FFFF)),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Verifying...',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        backgroundColor: Color(0xFF1A1B2E),
        textStyle: GoogleFonts.poppins(color: Colors.white),
      ),
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  Future<void> _sendOTP(AuthProvider authProvider) async {
    if (_phoneController.text.isEmpty) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    
    if (mounted) {
      setState(() {
        _isLoading = false;
        _isOTPStep = true;
      });
      _startResendTimer();
    }
  }

  Future<void> _verifyOTP(AuthProvider authProvider) async {
    if (_otpController.text.length != 6) return;
    
    setState(() => _isLoading = true);
    
    // Simulate verification
    await Future.delayed(Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // Verify OTP using AuthProvider
      bool success = await authProvider.verifyOTP(_otpController.text);
      
      if (success) {
        if (authProvider.isAuthenticated) {
          // Existing user - go to home
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (authProvider.isRegistering) {
          // New user - go to profile setup
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ProfileSetupScreen(),
            ),
          );
        }
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '❌ Invalid OTP. Please try again.',
              style: GoogleFonts.orbitron(color: Colors.white),
            ),
            backgroundColor: Colors.red.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _resendOTP(AuthProvider authProvider) async {
    setState(() => _canResend = false);
    _startResendTimer();
    
    // Simulate resend
    await Future.delayed(Duration(seconds: 1));
  }

  void _startResendTimer() {
    _resendTimer = 30;
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (mounted) {
        setState(() => _resendTimer--);
        if (_resendTimer <= 0) {
          setState(() => _canResend = true);
          return false;
        }
        return true;
      }
      return false;
    });
  }

  void _changePhoneNumber() {
    setState(() {
      _isOTPStep = false;
      _otpController.clear();
    });
  }

  Future<void> _authenticateWithBiometric() async {
    setState(() => _isLoading = true);
    
    // Simulate biometric authentication
    await Future.delayed(Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.signInWithBiometric();
      
      if (authProvider.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FuturisticHomeScreen()),
        );
      }
    }
  }
}

class SecurityScannerPainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;

  SecurityScannerPainter(this.animationValue, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF00FFFF).withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw scanning lines
    final scanY = size.height * animationValue;
    
    for (int i = 0; i < 5; i++) {
      final y = (scanY + i * 20) % size.height;
      final opacity = 1.0 - (i * 0.2);
      
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        Paint()
          ..color = Color(0xFF00FFFF).withOpacity(opacity * 0.5)
          ..strokeWidth = 1,
      );
    }

    // Draw corner brackets
    final cornerSize = 30.0;
    final corners = [
      Offset(50, 100), // Top-left
      Offset(size.width - 50, 100), // Top-right
      Offset(50, size.height - 100), // Bottom-left
      Offset(size.width - 50, size.height - 100), // Bottom-right
    ];

    for (final corner in corners) {
      // Draw corner brackets
      canvas.drawPath(
        Path()
          ..moveTo(corner.dx - cornerSize, corner.dy)
          ..lineTo(corner.dx - 10, corner.dy)
          ..moveTo(corner.dx, corner.dy - cornerSize)
          ..lineTo(corner.dx, corner.dy - 10),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}