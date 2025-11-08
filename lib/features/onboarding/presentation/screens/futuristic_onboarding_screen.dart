import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

import '../../../../shared/providers/theme_provider.dart';
import '../../../auth/presentation/screens/phone_verification_screen.dart';

class FuturisticOnboardingScreen extends StatefulWidget {
  const FuturisticOnboardingScreen({super.key});

  @override
  State<FuturisticOnboardingScreen> createState() => _FuturisticOnboardingScreenState();
}

class _FuturisticOnboardingScreenState extends State<FuturisticOnboardingScreen>
    with TickerProviderStateMixin {
  PageController _pageController = PageController();
  late AnimationController _backgroundController;
  late AnimationController _cardController;
  late AnimationController _particleController;
  int _currentIndex = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: "AI-POWERED CONVERSATIONS",
      subtitle: "Experience next-level messaging with our advanced AI assistant that understands context, emotions, and helps you communicate better than ever before.",
      icon: Icons.psychology,
      gradientColors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
      features: [
        "Smart auto-complete",
        "Emotion detection",
        "Context awareness",
        "Multi-language support"
      ],
    ),
    OnboardingData(
      title: "QUANTUM ENCRYPTION",
      subtitle: "Your messages are protected by military-grade quantum encryption, ensuring absolute privacy and security for all your communications.",
      icon: Icons.security,
      gradientColors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
      features: [
        "Quantum key distribution",
        "End-to-end encryption",
        "Zero-knowledge protocol",
        "Secure key storage"
      ],
    ),
    OnboardingData(
      title: "HOLOGRAPHIC CALLS",
      subtitle: "Step into the future with 3D holographic video calls, AR filters, and immersive communication experiences.",
      icon: Icons.video_call,
      gradientColors: [Color(0xFF44A08D), Color(0xFFFFD700)],
      features: [
        "3D holographic projection",
        "AR face filters",
        "Spatial audio",
        "Immersive environments"
      ],
    ),
    OnboardingData(
      title: "NEURAL INTERFACE",
      subtitle: "Connect your thoughts directly to messages with our brain-computer interface integration for the ultimate communication experience.",
      icon: Icons.device_hub,
      gradientColors: [Color(0xFFFFD700), Color(0xFFC0C0C0)],
      features: [
        "Thought-to-text",
        "Emotion transmission",
        "Direct neural link",
        "Biometric authentication"
      ],
    ),
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

    _cardController.forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _cardController.dispose();
    _particleController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
                // Animated background particles
                _buildQuantumParticles(isDarkMode),
                
                // Neural network overlay
                _buildNeuralNetworkOverlay(isDarkMode),
                
                // Main content
                SafeArea(
                  child: Column(
                    children: [
                      // Top bar with skip button
                      _buildTopBar(isDarkMode),
                      
                      // Main page view
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _onboardingData.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                            _cardController.reset();
                            _cardController.forward();
                          },
                          itemBuilder: (context, index) {
                            return _buildOnboardingPage(_onboardingData[index], isDarkMode);
                          },
                        ),
                      ),
                      
                      // Bottom navigation
                      _buildBottomNavigation(isDarkMode),
                    ],
                  ),
                ),
                
                // Floating AI assistant preview
                _buildFloatingAssistant(isDarkMode),
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
            final radius = 150 + (index * 20);
            final speed = 0.3 + (index % 4) * 0.2;
            final time = _particleController.value * speed;
            
            final x = MediaQuery.of(context).size.width / 2 + 
                     radius * math.cos(time + angle) * 0.7;
            final y = MediaQuery.of(context).size.height / 2 + 
                     radius * math.sin(time + angle) * 0.5;
            
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 2 + (index % 3),
                height: 2 + (index % 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _onboardingData[_currentIndex].gradientColors[0]
                      .withOpacity(0.3 + 0.3 * math.sin(time * 2 + index).abs()),
                  boxShadow: [
                    BoxShadow(
                      color: _onboardingData[_currentIndex].gradientColors[0]
                          .withOpacity(0.2),
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

  Widget _buildNeuralNetworkOverlay(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return CustomPaint(
          painter: OnboardingNeuralPainter(
            _backgroundController.value,
            _onboardingData[_currentIndex].gradientColors,
            isDarkMode,
          ),
          child: Container(),
        );
      },
    );
  }

  Widget _buildTopBar(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                  ),
                ),
                child: Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'DropMsg',
                style: GoogleFonts.orbitron(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Color(0xFF1A1B2E),
                ),
              ),
            ],
          ),
          
          // Skip button
          GestureDetector(
            onTap: () => _navigateToAuth(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF00FFFF).withOpacity(0.5),
                ),
              ),
              child: Text(
                'SKIP',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00FFFF),
                  letterSpacing: 1,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data, bool isDarkMode) {
    return AnimatedBuilder(
      animation: _cardController,
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              
              // Main card with holographic effect
              Expanded(
                child: Transform.scale(
                  scale: 0.8 + (_cardController.value * 0.2),
                  child: Transform.translate(
                    offset: Offset(0, 50 * (1 - _cardController.value)),
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
                            data.gradientColors[0].withOpacity(0.5),
                            data.gradientColors[1].withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(32.w),
                          child: Column(
                            children: [
                              // Icon with animation
                              _buildAnimatedIcon(data, isDarkMode),
                              
                              SizedBox(height: 40.h),
                              
                              // Title
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: data.gradientColors,
                                ).createShader(bounds),
                                child: Text(
                                  data.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.orbitron(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ).animate(delay: 200.ms).slideY(
                                begin: 1,
                                end: 0,
                                duration: 800.ms,
                                curve: Curves.easeOutBack,
                              ),
                              
                              SizedBox(height: 24.h),
                              
                              // Subtitle
                              Text(
                                data.subtitle,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 16.sp,
                                  color: isDarkMode 
                                      ? Colors.white.withOpacity(0.8)
                                      : Color(0xFF1A1B2E).withOpacity(0.8),
                                  height: 1.5,
                                ),
                              ).animate(delay: 400.ms).fadeIn(duration: 1000.ms),
                              
                              SizedBox(height: 32.h),
                              
                              // Features list
                              _buildFeaturesList(data, isDarkMode),
                              
                              Spacer(),
                              
                              // AI preview for first page
                              if (_currentIndex == 0)
                                _buildAIPreview(isDarkMode),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedIcon(OnboardingData data, bool isDarkMode) {
    return Container(
      width: 120.w,
      height: 120.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            data.gradientColors[0].withOpacity(0.3),
            data.gradientColors[1].withOpacity(0.1),
            Colors.transparent,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating rings
          ...List.generate(3, (index) {
            return Transform.rotate(
              angle: _backgroundController.value * (1 + index * 0.5),
              child: Container(
                width: (80 + index * 20).w,
                height: (80 + index * 20).w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: data.gradientColors[index % 2].withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
            );
          }),
          
          // Main icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: data.gradientColors,
              ),
            ),
            child: Icon(
              data.icon,
              color: Colors.white,
              size: 40.sp,
            ),
          ).animate().scale(
            delay: 300.ms,
            duration: 800.ms,
            curve: Curves.elasticOut,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(OnboardingData data, bool isDarkMode) {
    return Column(
      children: data.features.asMap().entries.map((entry) {
        final index = entry.key;
        final feature = entry.value;
        
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              Container(
                width: 6.w,
                height: 6.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: data.gradientColors,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  feature,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: isDarkMode 
                        ? Colors.white.withOpacity(0.7)
                        : Color(0xFF1A1B2E).withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ).animate(delay: Duration(milliseconds: 600 + (index * 100))).slideX(
            begin: -1,
            end: 0,
            duration: 600.ms,
            curve: Curves.easeOutBack,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAIPreview(bool isDarkMode) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF00FFFF).withOpacity(0.1),
        border: Border.all(
          color: Color(0xFF00FFFF).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ).animate(onPlay: (controller) => controller.repeat()).fadeIn(
                duration: 1000.ms,
              ).then().fadeOut(duration: 1000.ms),
              SizedBox(width: 8.w),
              Text(
                'AI Assistant Active',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Color(0xFF00FFFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '"Hello! I can help you write better messages, translate languages, and understand emotions in conversations."',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: isDarkMode 
                  ? Colors.white.withOpacity(0.8)
                  : Color(0xFF1A1B2E).withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ).animate(delay: 1000.ms).slideY(begin: 1, end: 0, duration: 800.ms);
  }

  Widget _buildBottomNavigation(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous button
          GestureDetector(
            onTap: _currentIndex > 0 ? _previousPage : null,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex > 0 
                    ? Color(0xFF00FFFF).withOpacity(0.2)
                    : Colors.transparent,
                border: Border.all(
                  color: _currentIndex > 0 
                      ? Color(0xFF00FFFF).withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: _currentIndex > 0 
                    ? Color(0xFF00FFFF)
                    : Colors.transparent,
                size: 24.sp,
              ),
            ),
          ),
          
          // Page indicators
          Row(
            children: List.generate(
              _onboardingData.length,
              (index) => _buildPageIndicator(index, isDarkMode),
            ),
          ),
          
          // Next/Get Started button
          GestureDetector(
            onTap: _currentIndex < _onboardingData.length - 1 
                ? _nextPage 
                : _navigateToAuth,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: _onboardingData[_currentIndex].gradientColors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _onboardingData[_currentIndex].gradientColors[0]
                        .withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Icon(
                _currentIndex < _onboardingData.length - 1 
                    ? Icons.arrow_forward_ios
                    : Icons.rocket_launch,
                color: Colors.white,
                size: 24.sp,
              ),
            ).animate().scale(
              duration: 200.ms,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index, bool isDarkMode) {
    final isActive = index == _currentIndex;
    final data = _onboardingData[index];
    
    return Container(
      width: isActive ? 24.w : 8.w,
      height: 8.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: isActive
            ? LinearGradient(colors: data.gradientColors)
            : null,
        color: isActive 
            ? null 
            : (isDarkMode ? Colors.white : Colors.black).withOpacity(0.3),
      ),
    ).animate().scale(duration: 300.ms);
  }

  Widget _buildFloatingAssistant(bool isDarkMode) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.15,
      right: 20.w,
      child: GlassmorphicContainer(
        width: 80.w,
        height: 80.w,
        borderRadius: 40,
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
            Color(0xFF00FFFF).withOpacity(0.5),
            Color(0xFF4ECDC4).withOpacity(0.3),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.psychology,
              color: Color(0xFF00FFFF),
              size: 32.sp,
            ),
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ).animate(onPlay: (controller) => controller.repeat()).scale(
                begin: Offset(0.5, 0.5),
                end: Offset(1.2, 1.2),
                duration: 1000.ms,
              ),
            ),
          ],
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
        begin: -5,
        end: 5,
        duration: 3000.ms,
      ),
    );
  }

  void _nextPage() {
    if (_currentIndex < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
            const PhoneVerificationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final List<String> features;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.features,
  });
}

class OnboardingNeuralPainter extends CustomPainter {
  final double animationValue;
  final List<Color> gradientColors;
  final bool isDarkMode;

  OnboardingNeuralPainter(this.animationValue, this.gradientColors, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gradientColors[0].withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw flowing neural connections
    for (int i = 0; i < 5; i++) {
      final path = Path();
      final startX = size.width * 0.2 * i;
      final waveHeight = 30 + i * 10;
      
      path.moveTo(0, size.height * 0.3 + i * size.height * 0.15);
      
      for (int j = 0; j <= 20; j++) {
        final x = (size.width / 20) * j;
        final y = size.height * 0.3 + i * size.height * 0.15 + 
                 waveHeight * math.sin(animationValue * 2 + j * 0.3 + i * 0.5);
        
        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}