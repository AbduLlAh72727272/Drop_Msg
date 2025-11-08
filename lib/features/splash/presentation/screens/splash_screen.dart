import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _particleController;
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    // Start background animation
    _backgroundController.forward();
    
    // Start particle animation after a delay
    await Future.delayed(const Duration(milliseconds: 500));
    _particleController.forward();
    
    // Start logo animation after another delay
    await Future.delayed(const Duration(milliseconds: 800));
    _logoController.forward();
    
    // Navigate to next screen after all animations
    await Future.delayed(const Duration(milliseconds: 4000));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.onboarding);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _particleController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryAqua.withOpacity(0.1),
              AppTheme.secondaryAqua.withOpacity(0.2),
              AppTheme.metallicSilver.withOpacity(0.1),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated Background Particles
            _buildAnimatedBackground(),
            
            // Glassmorphic overlay
            _buildGlassmorphicOverlay(),
            
            // Main content
            _buildMainContent(),
            
            // Floating particles
            _buildFloatingParticles(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryAqua.withOpacity(
                  0.1 * _backgroundController.value,
                ),
                AppTheme.secondaryAqua.withOpacity(
                  0.2 * _backgroundController.value,
                ),
                AppTheme.metallicGold.withOpacity(
                  0.15 * _backgroundController.value,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGlassmorphicOverlay() {
    return Positioned.fill(
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 0,
        blur: 20,
        alignment: Alignment.center,
        border: 0,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.transparent, Colors.transparent],
        ),
        child: const SizedBox(),
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo with advanced animations
          _buildAnimatedLogo(),
          
          SizedBox(height: 40.h),
          
          // App name with typing effect
          _buildAnimatedAppName(),
          
          SizedBox(height: 20.h),
          
          // Tagline with fade effect
          _buildAnimatedTagline(),
          
          SizedBox(height: 60.h),
          
          // Loading indicator
          _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryAqua.withOpacity(0.6),
            blurRadius: 30,
            spreadRadius: 10,
          ),
          BoxShadow(
            color: AppTheme.secondaryAqua.withOpacity(0.4),
            blurRadius: 60,
            spreadRadius: -10,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/drop_logo.png',
          fit: BoxFit.cover,
        ),
      ),
    )
        .animate(controller: _logoController)
        .scale(
          begin: const Offset(0.0, 0.0),
          end: const Offset(1.0, 1.0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
        )
        .fadeIn(
          duration: const Duration(milliseconds: 800),
        )
        .shimmer(
          duration: const Duration(milliseconds: 1200),
          color: AppTheme.primaryAqua.withOpacity(0.5),
        );
  }

  Widget _buildAnimatedAppName() {
    return Text(
      'DropMsg',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 1500))
        .slideY(
          begin: 1,
          end: 0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
        )
        .shimmer(
          delay: const Duration(milliseconds: 2000),
          duration: const Duration(milliseconds: 1500),
          color: AppTheme.primaryAqua.withOpacity(0.7),
        );
  }

  Widget _buildAnimatedTagline() {
    return Text(
      'Next Level Messaging',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        letterSpacing: 1.2,
        color: AppTheme.secondaryAqua,
      ),
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 2200))
        .slideY(
          begin: 1,
          end: 0,
          duration: const Duration(milliseconds: 600),
        );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      width: 60.w,
      height: 4.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: AppTheme.aquaGradient,
      ),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: const Duration(milliseconds: 1500),
          color: Colors.white.withOpacity(0.5),
        );
  }

  Widget _buildFloatingParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(15, (index) {
            final offset = Offset(
              (index * 50.0) % MediaQuery.of(context).size.width,
              (index * 80.0) % MediaQuery.of(context).size.height,
            );
            
            return Positioned(
              left: offset.dx,
              top: offset.dy,
              child: Transform.translate(
                offset: Offset(
                  0,
                  -100 * _particleController.value,
                ),
                child: Opacity(
                  opacity: (1.0 - _particleController.value) * 0.6,
                  child: Container(
                    width: (index % 3 + 1) * 4.0,
                    height: (index % 3 + 1) * 4.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primaryAqua.withOpacity(0.8),
                          AppTheme.secondaryAqua.withOpacity(0.6),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryAqua.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}