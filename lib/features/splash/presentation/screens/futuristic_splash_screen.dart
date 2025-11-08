import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../onboarding/presentation/screens/futuristic_onboarding_screen.dart';
import '../../../home/presentation/screens/futuristic_home_screen.dart';

class FuturisticSplashScreen extends StatefulWidget {
  const FuturisticSplashScreen({super.key});

  @override
  State<FuturisticSplashScreen> createState() => _FuturisticSplashScreenState();
}

class _FuturisticSplashScreenState extends State<FuturisticSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _backgroundController;
  late AnimationController _textController;
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // Start infinite background animations
    _backgroundController.repeat();
    _particleController.repeat();
    _glowController.repeat(reverse: true);
    
    // Logo animation with dramatic entrance
    await Future.delayed(const Duration(milliseconds: 800));
    _logoController.forward();
    
    // Text animation with staggered effects
    await Future.delayed(const Duration(milliseconds: 2000));
    _textController.forward();
    
    // Navigate after full animation sequence
    await Future.delayed(const Duration(milliseconds: 6000));
    if (mounted) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.checkAuthStatus();
      
      if (authProvider.isAuthenticated) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const FuturisticHomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1500),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const FuturisticOnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _particleController.dispose();
    _backgroundController.dispose();
    _textController.dispose();
    _glowController.dispose();
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
                // Dynamic particle background
                _buildQuantumParticles(isDarkMode),
                
                // Neural network pattern overlay
                _buildNeuralNetwork(isDarkMode),
                
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Holographic logo container
                      _buildHolographicLogo(isDarkMode),
                      
                      SizedBox(height: 60.h),
                      
                      // Advanced text animations
                      _buildQuantumText(isDarkMode),
                      
                      SizedBox(height: 80.h),
                      
                      // Futuristic loading system
                      _buildQuantumLoader(isDarkMode),
                    ],
                  ),
                ),
                
                // Floating UI elements
                _buildFloatingElements(isDarkMode),
                
                // Status indicators
                _buildStatusIndicators(isDarkMode),
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
          children: List.generate(50, (index) {
            final angle = (index / 50) * 2 * 3.14159;
            final radius = 200 + (index * 15);
            final speed = 0.5 + (index % 3) * 0.3;
            final time = _particleController.value * speed;
            
            final x = MediaQuery.of(context).size.width / 2 + 
                     radius * math.cos(time + angle) * 0.8;
            final y = MediaQuery.of(context).size.height / 2 + 
                     radius * math.sin(time + angle) * 0.6;
            
            final opacity = (0.5 + 0.5 * math.sin(time * 3 + index)).clamp(0.0, 1.0);
            
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 3 + (index % 3),
                height: 3 + (index % 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: [
                    const Color(0xFF00FFFF),
                    const Color(0xFF4ECDC4),
                    const Color(0xFF44A08D),
                    const Color(0xFFFFD700),
                    const Color(0xFFC0C0C0),
                  ][index % 5].withOpacity(opacity * 0.8),
                  boxShadow: [
                    BoxShadow(
                      color: [
                        const Color(0xFF00FFFF),
                        const Color(0xFF4ECDC4),
                        const Color(0xFF44A08D),
                        const Color(0xFFFFD700),
                        const Color(0xFFC0C0C0),
                      ][index % 5].withOpacity(opacity * 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
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
          painter: NeuralNetworkPainter(_backgroundController.value, isDarkMode),
          child: Container(),
        );
      },
    );
  }

  Widget _buildHolographicLogo(bool isDarkMode) {
    return AnimatedBuilder(
      animation: Listenable.merge([_logoController, _glowController]),
      builder: (context, child) {
        final logoScale = Curves.elasticOut.transform(_logoController.value);
        final glowIntensity = _glowController.value;
        
        return Transform.scale(
          scale: 0.3 + logoScale * 0.7,
          child: Transform.rotate(
            angle: _logoController.value * 0.1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow ring
                Container(
                  width: 240.w,
                  height: 240.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFF00FFFF).withOpacity(0.1 + glowIntensity * 0.3),
                        const Color(0xFF00FFFF).withOpacity(0.4 + glowIntensity * 0.6),
                      ],
                    ),
                  ),
                ),
                
                // Middle ring with rotation
                Transform.rotate(
                  angle: _backgroundController.value * 2,
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF00FFFF).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                
                // Inner ring with counter-rotation
                Transform.rotate(
                  angle: -_backgroundController.value * 1.5,
                  child: Container(
                    width: 160.w,
                    height: 160.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4ECDC4).withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                
                // Main logo container
                GlassmorphicContainer(
                  width: 180.w,
                  height: 180.w,
                  borderRadius: 90,
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
                      const Color(0xFF00FFFF).withOpacity(0.6),
                      const Color(0xFF4ECDC4).withOpacity(0.3),
                      const Color(0xFFFFD700).withOpacity(0.4),
                    ],
                  ),
                  child: ClipOval(
                    child: Stack(
                      children: [
                        // Your logo
                        Image.asset(
                          'assets/images/drop_logo.png',
                          width: 180.w,
                          height: 180.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Futuristic fallback
                            return Container(
                              width: 180.w,
                              height: 180.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF00FFFF),
                                    const Color(0xFF4ECDC4),
                                    const Color(0xFF44A08D),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.water_drop_outlined,
                                size: 90.sp,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        
                        // Holographic overlay
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF00FFFF).withOpacity(0.2),
                                Colors.transparent,
                                const Color(0xFF4ECDC4).withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(
          duration: 2000.ms,
          curve: Curves.easeOutCubic,
        );
      },
    );
  }

  Widget _buildQuantumText(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return Opacity(
          opacity: _textController.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _textController.value)),
            child: Column(
              children: [
                // Main app name with quantum effect
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      const Color(0xFF00FFFF),
                      const Color(0xFF4ECDC4),
                      const Color(0xFFFFD700),
                      const Color(0xFF00FFFF),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ).createShader(bounds),
                  child: Text(
                    'DropMsg',
                    style: GoogleFonts.orbitron(
                      fontSize: 42.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ).animate().slideX(
                  begin: -1,
                  end: 0,
                  duration: 1500.ms,
                  curve: Curves.easeOutBack,
                ).then().shimmer(
                  duration: 2000.ms,
                  color: const Color(0xFF00FFFF).withOpacity(0.5),
                ),
                
                SizedBox(height: 12.h),
                
                // Tagline with typewriter effect
                Text(
                  'THE FUTURE OF MESSAGING',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: isDarkMode 
                        ? Colors.white.withOpacity(0.9)
                        : const Color(0xFF1A1B2E).withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 3,
                  ),
                ).animate(delay: 800.ms).fadeIn(
                  duration: 1000.ms,
                ),
                
                SizedBox(height: 20.h),
                
                // Feature tags
                Wrap(
                  spacing: 12.w,
                  children: [
                    _buildFeatureTag('AI POWERED', isDarkMode),
                    _buildFeatureTag('QUANTUM SECURE', isDarkMode),
                    _buildFeatureTag('HOLOGRAPHIC', isDarkMode),
                  ],
                ).animate(delay: 1500.ms).fadeIn(duration: 1000.ms),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureTag(String text, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00FFFF).withOpacity(0.5),
          width: 1,
        ),
        color: const Color(0xFF00FFFF).withOpacity(0.1),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.sp,
          color: const Color(0xFF00FFFF),
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildQuantumLoader(bool isDarkMode) {
    return Column(
      children: [
        // Multi-ring loader
        SizedBox(
          width: 80.w,
          height: 80.w,
          child: Stack(
            children: [
              // Outer ring
              Positioned.fill(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    const Color(0xFF00FFFF).withOpacity(0.3),
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).rotate(),
              ),
              
              // Middle ring
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF4ECDC4)),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).rotate(),
                ),
              ),
              
              // Inner ring
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: const AlwaysStoppedAnimation(Color(0xFFFFD700)),
                  ).animate(onPlay: (controller) => controller.repeat()).rotate(),
                ),
              ),
              
              // Center pulse
              Center(
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00FFFF),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.5, 1.5),
                  duration: 1000.ms,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 24.h),
        
        // Status text with glitch effect
        Text(
          'INITIALIZING QUANTUM CORE...',
          style: GoogleFonts.poppins(
            fontSize: 11.sp,
            color: isDarkMode 
                ? Colors.white.withOpacity(0.7)
                : const Color(0xFF1A1B2E).withOpacity(0.7),
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 3000.ms,
          color: const Color(0xFF00FFFF).withOpacity(0.5),
        ),
      ],
    );
  }

  Widget _buildFloatingElements(bool isDarkMode) {
    return Stack(
      children: [
        // Top left AI indicator
        Positioned(
          top: 80.h,
          left: 30.w,
          child: _buildFloatingIcon(Icons.psychology, const Color(0xFF00FFFF), 3000),
        ),
        
        // Top right security indicator
        Positioned(
          top: 120.h,
          right: 40.w,
          child: _buildFloatingIcon(Icons.security, const Color(0xFF4ECDC4), 4000),
        ),
        
        // Bottom left quantum indicator
        Positioned(
          bottom: 140.h,
          left: 50.w,
          child: _buildFloatingIcon(Icons.auto_awesome, const Color(0xFFFFD700), 3500),
        ),
        
        // Bottom right hologram indicator
        Positioned(
          bottom: 180.h,
          right: 60.w,
          child: _buildFloatingIcon(Icons.graphic_eq, const Color(0xFF44A08D), 2800),
        ),
      ],
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color color, int duration) {
    return GlassmorphicContainer(
      width: 60.w,
      height: 60.w,
      borderRadius: 30,
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
          color.withOpacity(0.5),
          Colors.transparent,
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: 24.sp,
      ),
    ).animate(onPlay: (controller) => controller.repeat(reverse: true)).moveY(
      begin: -10,
      end: 10,
      duration: Duration(milliseconds: duration),
    );
  }

  Widget _buildStatusIndicators(bool isDarkMode) {
    return Positioned(
      bottom: 30.h,
      right: 20.w,
      child: Column(
        children: [
          _buildStatusDot('NEURAL NET', Colors.green),
          SizedBox(height: 8.h),
          _buildStatusDot('QUANTUM LINK', Colors.blue),
          SizedBox(height: 8.h),
          _buildStatusDot('AI CORE', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatusDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 8.sp,
            color: color.withOpacity(0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 6.w),
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ).animate(onPlay: (controller) => controller.repeat()).fadeIn(
          duration: 1000.ms,
        ).then().fadeOut(duration: 1000.ms),
      ],
    );
  }
}

// Neural network painter for background effect
class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;

  NeuralNetworkPainter(this.animationValue, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDarkMode ? Colors.white : Colors.black).withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw interconnected nodes
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 6; j++) {
        final x = (size.width / 7) * i;
        final y = (size.height / 5) * j;
        
        // Add wave motion
        final waveOffset = 20 * math.sin(animationValue * 2 + i * 0.5 + j * 0.3);
        
        // Draw node
        canvas.drawCircle(
          Offset(x + waveOffset, y),
          2,
          Paint()..color = const Color(0xFF00FFFF).withOpacity(0.3),
        );
        
        // Draw connections
        if (i < 7) {
          canvas.drawLine(
            Offset(x + waveOffset, y),
            Offset(x + size.width / 7, y),
            paint,
          );
        }
        if (j < 5) {
          canvas.drawLine(
            Offset(x + waveOffset, y),
            Offset(x, y + size.height / 5),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}