import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Next-Level Messaging",
      description: "Experience the future of communication with AI-powered features, holographic interfaces, and quantum-encrypted security.",
      icon: Icons.auto_awesome,
      gradient: AppTheme.aquaGradient,
    ),
    OnboardingData(
      title: "Ultra-Secure Communications",
      description: "Your privacy is paramount. Advanced encryption, disappearing messages, and biometric locks keep your conversations safe.",
      icon: Icons.security,
      gradient: AppTheme.metallicGradient,
    ),
    OnboardingData(
      title: "Immersive Media Sharing",
      description: "Share like never before with 4K video calls, AR stickers, holographic messages, and real-time collaboration tools.",
      icon: Icons.videocam,
      gradient: AppTheme.aquaGradient,
    ),
    OnboardingData(
      title: "AI-Powered Intelligence",
      description: "Smart replies, language translation, mood detection, and personalized experiences powered by advanced AI.",
      icon: Icons.psychology,
      gradient: AppTheme.metallicGradient,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToAuth() {
    Navigator.pushReplacementNamed(context, AppRouter.phoneAuth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              AppTheme.primaryAqua.withOpacity(0.1),
              AppTheme.metallicSilver.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(child: _buildPageView()),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryAqua.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/drop_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'DropMsg',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryAqua,
                ),
              ),
            ],
          ),
          
          // Skip button
          TextButton(
            onPressed: _navigateToAuth,
            child: Text(
              'Skip',
              style: TextStyle(
                color: AppTheme.secondaryAqua,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
        _animationController.forward().then((_) {
          _animationController.reset();
        });
      },
      itemCount: _pages.length,
      itemBuilder: (context, index) {
        return _buildOnboardingPage(_pages[index]);
      },
    );
  }

  Widget _buildOnboardingPage(OnboardingData data) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with glassmorphic container
          Container(
            width: 200.w,
            height: 200.h,
            margin: EdgeInsets.only(bottom: 40.h),
            child: GlassmorphicContainer(
              width: 200.w,
              height: 200.h,
              borderRadius: 100,
              blur: 20,
              alignment: Alignment.center,
              border: 2,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: data.gradient,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: data.gradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryAqua.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  data.icon,
                  size: 80.sp,
                  color: Colors.white,
                ),
              ),
            ),
          )
              .animate()
              .scale(
                delay: const Duration(milliseconds: 100),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
              )
              .shimmer(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 1000),
              ),

          // Title
          Text(
            data.title,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 28.sp,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 300))
              .slideY(
                begin: 0.3,
                end: 0,
                duration: const Duration(milliseconds: 500),
              ),

          SizedBox(height: 24.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              data.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16.sp,
                height: 1.6,
                color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 500))
              .slideY(
                begin: 0.3,
                end: 0,
                duration: const Duration(milliseconds: 500),
              ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          // Page indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: _pages.length,
            effect: WormEffect(
              activeDotColor: AppTheme.primaryAqua,
              dotColor: AppTheme.primaryAqua.withOpacity(0.3),
              dotWidth: 12.w,
              dotHeight: 12.h,
              spacing: 16.w,
            ),
          ),

          SizedBox(height: 40.h),

          // Navigation buttons
          Row(
            children: [
              // Back button
              if (_currentPage > 0)
                Expanded(
                  child: CustomButton(
                    text: 'Back',
                    onPressed: _previousPage,
                    variant: ButtonVariant.outline,
                  ),
                ),
              
              if (_currentPage > 0) SizedBox(width: 16.w),
              
              // Next/Get Started button
              Expanded(
                flex: _currentPage == 0 ? 1 : 1,
                child: CustomButton(
                  text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                  onPressed: _nextPage,
                  variant: ButtonVariant.gradient,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}