import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math' as math;

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../home/presentation/screens/futuristic_home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _cardController;
  late AnimationController _particleController;
  late AnimationController _aiController;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  
  File? _selectedImage;
  int _currentStep = 0;
  bool _isLoading = false;

  final List<String> _predefinedAvatars = [
    '👨‍🚀', '👩‍🚀', '🦾', '🤖', '👨‍💻', '👩‍💻', 
    '🧬', '⚡', '🔮', '🌟', '💫', '🚀'
  ];
  
  String? _selectedAvatar;
  bool _enableAI = true;
  bool _enableBiometric = true;
  bool _enableQuantumEncryption = true;
  bool _enableHolographicCalls = true;

  final List<String> _setupSteps = [
    'Avatar & Basic Info',
    'Privacy & Security',
    'AI Preferences',
    'Final Setup'
  ];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _aiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _cardController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _cardController.dispose();
    _particleController.dispose();
    _aiController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
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
                
                // Neural network overlay
                _buildNeuralNetwork(isDarkMode),
                
                // Main content
                SafeArea(
                  child: Column(
                    children: [
                      // Header with progress
                      _buildHeader(isDarkMode),
                      
                      // Main setup card
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: _buildSetupCard(isDarkMode, authProvider),
                        ),
                      ),
                      
                      // Navigation buttons
                      _buildNavigationButtons(isDarkMode, authProvider),
                    ],
                  ),
                ),
                
                // Floating AI assistant
                _buildFloatingAI(isDarkMode),
                
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
          children: List.generate(30, (index) {
            final angle = (index / 30) * 2 * 3.14159;
            final radius = 120 + (index * 12);
            final speed = 0.3 + (index % 4) * 0.15;
            final time = _particleController.value * speed;
            
            final x = MediaQuery.of(context).size.width / 2 + 
                     radius * math.cos(time + angle) * 0.8;
            final y = MediaQuery.of(context).size.height / 2 + 
                     radius * math.sin(time + angle) * 0.6;
            
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 2 + (index % 3),
                height: 2 + (index % 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: [
                    const Color(0xFF00FFFF),
                    const Color(0xFF4ECDC4),
                    const Color(0xFFFFD700),
                    const Color(0xFF44A08D),
                  ][index % 4].withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: [
                        const Color(0xFF00FFFF),
                        const Color(0xFF4ECDC4),
                        const Color(0xFFFFD700),
                        const Color(0xFF44A08D),
                      ][index % 4].withOpacity(0.3),
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

  Widget _buildNeuralNetwork(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return CustomPaint(
          painter: ProfileNeuralPainter(_backgroundController.value, isDarkMode),
          child: Container(),
        );
      },
    );
  }

  Widget _buildHeader(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          // Title and step indicator
          Row(
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
                      'PROFILE INITIALIZATION',
                      style: GoogleFonts.orbitron(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : const Color(0xFF1A1B2E),
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Step ${_currentStep + 1} of ${_setupSteps.length}',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: const Color(0xFF00FFFF),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 50.w), // Balance layout
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Progress indicator
          _buildProgressIndicator(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(bool isDarkMode) {
    return Row(
      children: List.generate(_setupSteps.length, (index) {
        final isCompleted = index < _currentStep;
        final isActive = index == _currentStep;
        
        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: isCompleted || isActive
                        ? LinearGradient(
                            colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                          )
                        : null,
                    color: isCompleted || isActive 
                        ? null 
                        : Colors.white.withOpacity(0.3),
                  ),
                ).animate().scale(
                  duration: 300.ms,
                  curve: Curves.easeInOut,
                ),
              ),
              if (index < _setupSteps.length - 1) SizedBox(width: 8.w),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSetupCard(bool isDarkMode, AuthProvider authProvider) {
    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.9 + (_cardController.value * 0.1),
          child: Opacity(
            opacity: _cardController.value,
            child: GlassmorphicContainer(
              width: double.infinity,
              height: double.infinity,
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
                child: _buildStepContent(isDarkMode),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStepContent(bool isDarkMode) {
    switch (_currentStep) {
      case 0:
        return _buildAvatarStep(isDarkMode);
      case 1:
        return _buildPrivacyStep(isDarkMode);
      case 2:
        return _buildAIPreferencesStep(isDarkMode);
      case 3:
        return _buildFinalStep(isDarkMode);
      default:
        return Container();
    }
  }

  Widget _buildAvatarStep(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Step title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4), Color(0xFFFFD700)],
          ).createShader(bounds),
          child: Text(
            'CREATE YOUR AVATAR',
            style: GoogleFonts.orbitron(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 30.h),
        
        // Avatar selection
        _buildAvatarSelection(isDarkMode),
        
        SizedBox(height: 30.h),
        
        // Name input
        _buildInputField(
          controller: _nameController,
          label: 'DISPLAY NAME',
          hint: 'Enter your display name',
          icon: Icons.person,
          isDarkMode: isDarkMode,
        ),
        
        SizedBox(height: 20.h),
        
        // Username input
        _buildInputField(
          controller: _usernameController,
          label: 'USERNAME',
          hint: '@username',
          icon: Icons.alternate_email,
          isDarkMode: isDarkMode,
          prefix: '@',
        ),
        
        SizedBox(height: 20.h),
        
        // Bio input
        _buildInputField(
          controller: _bioController,
          label: 'BIO',
          hint: 'Tell us about yourself...',
          icon: Icons.edit,
          isDarkMode: isDarkMode,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildAvatarSelection(bool isDarkMode) {
    return Column(
      children: [
        // Current avatar display
        GestureDetector(
          onTap: _pickImageFromGallery,
          child: Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
              ),
              border: Border.all(color: Color(0xFF00FFFF), width: 3),
            ),
            child: ClipOval(
              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.cover)
                  : _selectedAvatar != null
                      ? Center(
                          child: Text(
                            _selectedAvatar!,
                            style: TextStyle(fontSize: 50.sp),
                          ),
                        )
                      : Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: 40.sp,
                        ),
            ),
          ).animate().scale(
            duration: 300.ms,
            curve: Curves.elasticOut,
          ),
        ),
        
        SizedBox(height: 20.h),
        
        Text(
          'Tap to add photo or select avatar below',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
          ),
        ),
        
        SizedBox(height: 20.h),
        
        // Predefined avatars
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: _predefinedAvatars.map((avatar) {
            final isSelected = _selectedAvatar == avatar;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAvatar = avatar;
                  _selectedImage = null;
                });
              },
              child: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? Color(0xFF00FFFF) : Colors.transparent,
                    width: 2,
                  ),
                  color: isSelected 
                      ? Color(0xFF00FFFF).withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                ),
              ).animate().scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPrivacyStep(bool isDarkMode) {
    return Column(
      children: [
        // Step title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D), Color(0xFFFFD700)],
          ).createShader(bounds),
          child: Text(
            'SECURITY & PRIVACY',
            style: GoogleFonts.orbitron(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 30.h),
        
        // Security options
        _buildSecurityOption(
          'Biometric Authentication',
          'Use fingerprint or face recognition for secure access',
          Icons.fingerprint,
          _enableBiometric,
          (value) => setState(() => _enableBiometric = value),
          [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
          isDarkMode,
        ),
        
        SizedBox(height: 20.h),
        
        _buildSecurityOption(
          'Quantum Encryption',
          'Military-grade encryption for all your messages',
          Icons.security,
          _enableQuantumEncryption,
          (value) => setState(() => _enableQuantumEncryption = value),
          [Color(0xFF4ECDC4), Color(0xFF44A08D)],
          isDarkMode,
        ),
        
        SizedBox(height: 20.h),
        
        _buildSecurityOption(
          'Holographic Calls',
          'Enable 3D holographic video calling features',
          Icons.video_call,
          _enableHolographicCalls,
          (value) => setState(() => _enableHolographicCalls = value),
          [Color(0xFF44A08D), Color(0xFFFFD700)],
          isDarkMode,
        ),
        
        Spacer(),
        
        // Privacy info
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFF00FFFF).withOpacity(0.1),
            border: Border.all(color: Color(0xFF00FFFF).withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.shield,
                color: Color(0xFF00FFFF),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Your data is protected by zero-knowledge protocols. We cannot access your personal information.',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAIPreferencesStep(bool isDarkMode) {
    return Column(
      children: [
        // Step title
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFFA500), Color(0xFF00FFFF)],
          ).createShader(bounds),
          child: Text(
            'AI ASSISTANT SETUP',
            style: GoogleFonts.orbitron(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 30.h),
        
        // AI avatar with animation
        AnimatedBuilder(
          animation: _aiController,
          builder: (context, child) {
            return Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFFFFD700).withOpacity(0.8),
                    Color(0xFF00FFFF).withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Rotating ring
                  Transform.rotate(
                    angle: _aiController.value * 2 * 3.14159,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFFFFD700).withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  // AI icon
                  Icon(
                    Icons.psychology,
                    color: Color(0xFFFFD700),
                    size: 40.sp,
                  ),
                ],
              ),
            );
          },
        ),
        
        SizedBox(height: 30.h),
        
        // AI toggle
        _buildSecurityOption(
          'Enable AI Assistant',
          'Get smart suggestions, auto-complete, and conversation help',
          Icons.psychology,
          _enableAI,
          (value) => setState(() => _enableAI = value),
          [Color(0xFFFFD700), Color(0xFFFFA500)],
          isDarkMode,
        ),
        
        if (_enableAI) ...[
          SizedBox(height: 30.h),
          
          // AI capabilities preview
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFFFD700).withOpacity(0.1),
              border: Border.all(color: Color(0xFFFFD700).withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Capabilities:',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFD700),
                  ),
                ),
                SizedBox(height: 12.h),
                ...['Smart message suggestions', 'Real-time translation', 'Emotion detection', 'Context understanding']
                    .map((capability) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Color(0xFFFFD700),
                            size: 16.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            capability,
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
        
        Spacer(),
        
        // AI introduction
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [
                Color(0xFF00FFFF).withOpacity(0.1),
                Color(0xFFFFD700).withOpacity(0.1),
              ],
            ),
          ),
          child: Column(
            children: [
              Text(
                '"Hello! I\'m your AI assistant. I\'ll help you communicate better, understand emotions in conversations, and provide smart suggestions."',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black.withOpacity(0.9),
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                '- DropMsg AI',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFFFFD700),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFinalStep(bool isDarkMode) {
    return Column(
      children: [
        // Completion animation
        Container(
          width: 150.w,
          height: 150.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color(0xFF00FFFF).withOpacity(0.3),
                Color(0xFF4ECDC4).withOpacity(0.2),
                Colors.transparent,
              ],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating rings
              ...List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _backgroundController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _backgroundController.value * (1 + index * 0.5),
                      child: Container(
                        width: (100 + index * 20).w,
                        height: (100 + index * 20).w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: [
                              Color(0xFF00FFFF),
                              Color(0xFF4ECDC4),
                              Color(0xFFFFD700),
                            ][index].withOpacity(0.4),
                            width: 2,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
              
              // Checkmark icon
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40.sp,
                ),
              ).animate().scale(
                duration: 1000.ms,
                curve: Curves.elasticOut,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 40.h),
        
        // Welcome message
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4), Color(0xFFFFD700)],
          ).createShader(bounds),
          child: Text(
            'WELCOME TO THE FUTURE',
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ),
        
        SizedBox(height: 20.h),
        
        Text(
          'Your profile has been initialized with quantum-level security. You\'re now ready to experience the next generation of messaging.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
            height: 1.6,
          ),
        ),
        
        SizedBox(height: 40.h),
        
        // Features summary
        _buildFeatureSummary(isDarkMode),
      ],
    );
  }

  Widget _buildFeatureSummary(bool isDarkMode) {
    final enabledFeatures = [
      if (_enableAI) {'icon': Icons.psychology, 'text': 'AI Assistant'},
      if (_enableBiometric) {'icon': Icons.fingerprint, 'text': 'Biometric Auth'},
      if (_enableQuantumEncryption) {'icon': Icons.security, 'text': 'Quantum Encryption'},
      if (_enableHolographicCalls) {'icon': Icons.video_call, 'text': 'Holographic Calls'},
    ];

    return Column(
      children: [
        Text(
          'Enabled Features:',
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00FFFF),
          ),
        ),
        SizedBox(height: 20.h),
        Wrap(
          spacing: 16.w,
          runSpacing: 16.h,
          children: enabledFeatures.map((feature) {
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xFF00FFFF).withOpacity(0.1),
                border: Border.all(color: Color(0xFF00FFFF).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Icon(
                    feature['icon'] as IconData,
                    color: Color(0xFF00FFFF),
                    size: 24.sp,
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
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSecurityOption(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
    List<Color> gradientColors,
    bool isDarkMode,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: value 
              ? gradientColors[0].withOpacity(0.5)
              : Colors.white.withOpacity(0.2),
        ),
        color: value 
            ? gradientColors[0].withOpacity(0.1)
            : Colors.transparent,
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: value ? LinearGradient(colors: gradientColors) : null,
              color: value ? null : Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              icon,
              color: value ? Colors.white : gradientColors[0],
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: gradientColors[0],
            activeTrackColor: gradientColors[0].withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDarkMode,
    String? prefix,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00FFFF),
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Color(0xFF00FFFF).withOpacity(0.3),
            ),
            color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.05),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.5),
              ),
              prefixIcon: Icon(icon, color: Color(0xFF00FFFF)),
              prefixText: prefix,
              prefixStyle: GoogleFonts.poppins(
                color: Color(0xFF00FFFF),
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(bool isDarkMode, AuthProvider authProvider) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Row(
        children: [
          // Previous button
          if (_currentStep > 0)
            Expanded(
              child: GestureDetector(
                onTap: _previousStep,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Color(0xFF00FFFF).withOpacity(0.5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'PREVIOUS',
                      style: GoogleFonts.orbitron(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          
          if (_currentStep > 0) SizedBox(width: 16.w),
          
          // Next/Complete button
          Expanded(
            flex: _currentStep == 0 ? 1 : 2,
            child: GestureDetector(
              onTap: () => _currentStep < _setupSteps.length - 1 
                  ? _nextStep() 
                  : _completeSetup(authProvider),
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF00FFFF).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _currentStep < _setupSteps.length - 1 ? 'NEXT' : 'ENTER THE FUTURE',
                    style: GoogleFonts.orbitron(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ).animate().scale(duration: 200.ms),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingAI(bool isDarkMode) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.25,
      right: 20.w,
      child: AnimatedBuilder(
        animation: _aiController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 10 * (0.5 * math.sin(_aiController.value * 2 * 3.14159))),
            child: GlassmorphicContainer(
              width: 70.w,
              height: 70.w,
              borderRadius: 35,
              blur: 15,
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
                  Color(0xFFFFD700).withOpacity(0.5),
                  Color(0xFFFFA500).withOpacity(0.3),
                ],
              ),
              child: Icon(
                Icons.psychology,
                color: Color(0xFFFFD700),
                size: 28.sp,
              ),
            ),
          );
        },
      ),
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
                'Creating Profile...',
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

  void _nextStep() {
    if (_currentStep < _setupSteps.length - 1) {
      setState(() => _currentStep++);
      _cardController.reset();
      _cardController.forward();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
      _cardController.reset();
      _cardController.forward();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _selectedAvatar = null;
      });
    }
  }

  Future<void> _completeSetup(AuthProvider authProvider) async {
    setState(() => _isLoading = true);
    
    try {
      // Prepare user data for registration
      String userName = _nameController.text.trim();
      if (userName.isEmpty) {
        userName = 'Quantum User';
      }
      
      String? userImage = _selectedImage?.path ?? (_selectedAvatar != null ? 'emoji:$_selectedAvatar' : null);
      
      // Prepare preferences
      Map<String, dynamic> preferences = {
        'bio': _bioController.text.trim(),
        'username': _usernameController.text.trim(),
        'enableAI': _enableAI,
        'enableBiometric': _enableBiometric,
        'enableQuantumEncryption': _enableQuantumEncryption,
        'enableHolographicCalls': _enableHolographicCalls,
        'setupCompletedAt': DateTime.now().toIso8601String(),
      };
      
      // Complete registration using AuthProvider
      bool success = await authProvider.completeRegistration(
        name: userName,
        image: userImage,
        preferences: preferences,
      );
      
      if (mounted) {
        setState(() => _isLoading = false);
        
        if (success) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '🎉 Welcome to the future, $userName!',
                style: GoogleFonts.orbitron(color: Colors.white),
              ),
              backgroundColor: Colors.green.withOpacity(0.8),
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          // Navigate to home
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => 
                  const FuturisticHomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    )),
                    child: child,
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 800),
            ),
          );
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '❌ Registration failed. Please try again.',
                style: GoogleFonts.orbitron(color: Colors.white),
              ),
              backgroundColor: Colors.red.withOpacity(0.8),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '⚠️ An error occurred during registration.',
              style: GoogleFonts.orbitron(color: Colors.white),
            ),
            backgroundColor: Colors.orange.withOpacity(0.8),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _selectAvatar(String avatar) {
    setState(() {
      _selectedAvatar = avatar;
      _selectedImage = null;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _selectedAvatar = null;
      });
    }
  }
}

class ProfileNeuralPainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;

  ProfileNeuralPainter(this.animationValue, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDarkMode ? Colors.white : Colors.black).withOpacity(0.08)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw neural network connections
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 4; j++) {
        final x = (size.width / 5) * i;
        final y = (size.height / 3) * j;
        
        // Add wave motion
        final waveOffset = 15 * math.sin(animationValue * 2 + i * 0.3 + j * 0.4);
        
        // Draw connection lines
        if (i < 5) {
          canvas.drawLine(
            Offset(x + waveOffset, y),
            Offset(x + size.width / 5, y),
            paint,
          );
        }
        if (j < 3) {
          canvas.drawLine(
            Offset(x + waveOffset, y),
            Offset(x, y + size.height / 3),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}