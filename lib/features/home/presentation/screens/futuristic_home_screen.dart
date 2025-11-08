import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/providers/theme_provider.dart';

class FuturisticHomeScreen extends StatefulWidget {
  const FuturisticHomeScreen({super.key});

  @override
  State<FuturisticHomeScreen> createState() => _FuturisticHomeScreenState();
}

class _FuturisticHomeScreenState extends State<FuturisticHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _particleController;
  late AnimationController _hologramController;
  late AnimationController _fabController;

  int _selectedIndex = 0;
  bool _isMenuExpanded = false;

  final List<String> _navItems = ['Messages', 'Calls', 'AI', 'Profile'];
  final List<IconData> _navIcons = [
    Icons.chat_bubble_outline,
    Icons.videocam_outlined,
    Icons.psychology_outlined,
    Icons.person_outline,
  ];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _hologramController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _particleController.dispose();
    _hologramController.dispose();
    _fabController.dispose();
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
                      // Futuristic header
                      _buildFuturisticHeader(isDarkMode),
                      
                      // Main content area
                      Expanded(
                        child: _buildMainContent(isDarkMode),
                      ),
                    ],
                  ),
                ),
                
                // Futuristic navigation
                _buildFuturisticNavigation(isDarkMode),
                
                // Floating action buttons
                _buildFloatingActions(isDarkMode),
                
                // AI assistant overlay
                _buildAIAssistantOverlay(isDarkMode),
                
                // Holographic effects
                _buildHolographicEffects(isDarkMode),
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
          children: List.generate(40, (index) {
            final angle = (index / 40) * 2 * 3.14159;
            final radius = 100 + (index * 15);
            final speed = 0.2 + (index % 5) * 0.1;
            final time = _particleController.value * speed;
            
            final x = MediaQuery.of(context).size.width / 2 + 
                     radius * math.cos(time + angle) * 0.9;
            final y = MediaQuery.of(context).size.height / 2 + 
                     radius * math.sin(time + angle) * 0.7;
            
            return Positioned(
              left: x,
              top: y,
              child: Container(
                width: 1 + (index % 4),
                height: 1 + (index % 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: [
                    const Color(0xFF00FFFF),
                    const Color(0xFF4ECDC4),
                    const Color(0xFFFFD700),
                    const Color(0xFF44A08D),
                    const Color(0xFFC0C0C0),
                  ][index % 5].withOpacity(0.4 + 0.4 * math.sin(time * 3 + index).abs()),
                  boxShadow: [
                    BoxShadow(
                      color: [
                        const Color(0xFF00FFFF),
                        const Color(0xFF4ECDC4),
                        const Color(0xFFFFD700),
                        const Color(0xFF44A08D),
                        const Color(0xFFC0C0C0),
                      ][index % 5].withOpacity(0.2),
                      blurRadius: 4,
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
          painter: HomeNeuralPainter(_backgroundController.value, isDarkMode),
          child: Container(),
        );
      },
    );
  }

  Widget _buildFuturisticHeader(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          // Logo and title
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                    ),
                  ),
                  child: Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ).animate(onPlay: (controller) => controller.repeat()).rotate(
                  duration: 10000.ms,
                ),
                
                SizedBox(width: 12.w),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [Color(0xFF00FFFF), Color(0xFFFFD700)],
                      ).createShader(bounds),
                      child: Text(
                        'DropMsg',
                        style: GoogleFonts.orbitron(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      'Quantum Network Active',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Color(0xFF00FFFF),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Status indicators
          Row(
            children: [
              _buildStatusIndicator(Icons.security, Color(0xFF00FFFF), 'Secure'),
              SizedBox(width: 8.w),
              _buildStatusIndicator(Icons.psychology, Color(0xFFFFD700), 'AI'),
              SizedBox(width: 8.w),
              _buildStatusIndicator(Icons.wifi, Color(0xFF4ECDC4), 'Online'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(IconData icon, Color color, String tooltip) {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Icon(
        icon,
        color: color,
        size: 16.sp,
      ),
    ).animate(onPlay: (controller) => controller.repeat()).fadeIn(
      duration: 2000.ms,
    ).then().fadeOut(duration: 2000.ms);
  }

  Widget _buildMainContent(bool isDarkMode) {
    switch (_selectedIndex) {
      case 0:
        return _buildMessagesView(isDarkMode);
      case 1:
        return _buildCallsView(isDarkMode);
      case 2:
        return _buildAIView(isDarkMode);
      case 3:
        return _buildProfileView(isDarkMode);
      default:
        return _buildMessagesView(isDarkMode);
    }
  }

  Widget _buildMessagesView(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Search bar
          _buildHolographicSearchBar(isDarkMode),
          
          SizedBox(height: 20.h),
          
          // Messages list
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildHolographicMessageCard(
                  'Contact ${index + 1}',
                  'Last message preview with quantum encryption...',
                  '${(index + 1) * 2}m ago',
                  index % 3 == 0,
                  isDarkMode,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallsView(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Call options
          Row(
            children: [
              Expanded(
                child: _buildCallOption(
                  'Holographic Call',
                  Icons.videocam,
                  [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                  isDarkMode,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildCallOption(
                  'Neural Voice',
                  Icons.call,
                  [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                  isDarkMode,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Recent calls
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildCallHistoryCard(
                  'Contact ${index + 1}',
                  index % 2 == 0 ? 'Incoming' : 'Outgoing',
                  '${(index + 1) * 15}m ago',
                  index % 3 == 0,
                  isDarkMode,
                  index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIView(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // AI status
          _buildAIStatusCard(isDarkMode),
          
          SizedBox(height: 20.h),
          
          // AI features
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              children: [
                _buildAIFeatureCard(
                  'Smart Suggestions',
                  Icons.lightbulb_outline,
                  [Color(0xFFFFD700), Color(0xFFFFA500)],
                  isDarkMode,
                ),
                _buildAIFeatureCard(
                  'Emotion Detector',
                  Icons.mood,
                  [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                  isDarkMode,
                ),
                _buildAIFeatureCard(
                  'Auto Translate',
                  Icons.translate,
                  [Color(0xFF4ECDC4), Color(0xFF44A08D)],
                  isDarkMode,
                ),
                _buildAIFeatureCard(
                  'Voice Clone',
                  Icons.record_voice_over,
                  [Color(0xFF44A08D), Color(0xFFFFD700)],
                  isDarkMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView(bool isDarkMode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Profile card
          _buildHolographicProfileCard(isDarkMode),
          
          SizedBox(height: 20.h),
          
          // Profile options
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(
                  'Quantum Settings',
                  Icons.settings,
                  Color(0xFF00FFFF),
                  isDarkMode,
                ),
                _buildProfileOption(
                  'Security Center',
                  Icons.security,
                  Color(0xFF4ECDC4),
                  isDarkMode,
                ),
                _buildProfileOption(
                  'Neural Preferences',
                  Icons.psychology,
                  Color(0xFFFFD700),
                  isDarkMode,
                ),
                _buildProfileOption(
                  'Hologram Config',
                  Icons.video_settings,
                  Color(0xFF44A08D),
                  isDarkMode,
                ),
                _buildProfileOption(
                  'Data Vault',
                  Icons.storage,
                  Color(0xFFC0C0C0),
                  isDarkMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolographicSearchBar(bool isDarkMode) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 50.h,
      borderRadius: 25,
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
      child: TextFormField(
        style: GoogleFonts.poppins(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          hintText: 'Search quantum network...',
          hintStyle: GoogleFonts.poppins(
            color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.5),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xFF00FFFF),
          ),
          suffixIcon: Icon(
            Icons.mic,
            color: Color(0xFFFFD700),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
      ),
    );
  }

  Widget _buildHolographicMessageCard(
    String name,
    String message,
    String time,
    bool isUnread,
    bool isDarkMode,
    int index,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80.h,
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
            (isUnread ? Color(0xFFFFD700) : Color(0xFF00FFFF)).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00FFFF),
                      Color(0xFF4ECDC4),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: GoogleFonts.orbitron(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              SizedBox(width: 16.w),
              
              // Message content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFD700),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      message,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: 12.w),
              
              // Time and status
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    time,
                    style: GoogleFonts.poppins(
                      fontSize: 10.sp,
                      color: Color(0xFF00FFFF),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Icon(
                    Icons.lock,
                    size: 12.sp,
                    color: Color(0xFF4ECDC4),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: index * 100)).slideX(
      begin: 1,
      end: 0,
      duration: 600.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildCallOption(
    String title,
    IconData icon,
    List<Color> gradient,
    bool isDarkMode,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 100.h,
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
          gradient[0].withOpacity(0.5),
          gradient[1].withOpacity(0.3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: gradient),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 200.ms);
  }

  Widget _buildCallHistoryCard(
    String name,
    String type,
    String time,
    bool isMissed,
    bool isDarkMode,
    int index,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 70.h,
        borderRadius: 15,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.04),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Color(0xFF00FFFF).withOpacity(0.3),
            Colors.transparent,
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Icon(
                type == 'Incoming' ? Icons.call_received : Icons.call_made,
                color: isMissed ? Colors.red : Color(0xFF4ECDC4),
                size: 20.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      type,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 10.sp,
                  color: Color(0xFF00FFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: Duration(milliseconds: index * 100)).slideX(
      begin: 1,
      end: 0,
      duration: 600.ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildAIStatusCard(bool isDarkMode) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 120.h,
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
          Color(0xFFFFD700).withOpacity(0.5),
          Color(0xFF00FFFF).withOpacity(0.3),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _hologramController,
              builder: (context, child) {
                return Container(
                  width: 80.w,
                  height: 80.w,
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
                      Transform.rotate(
                        angle: _hologramController.value * 2 * 3.14159,
                        child: Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFFFD700).withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.psychology,
                        color: Color(0xFFFFD700),
                        size: 32.sp,
                      ),
                    ],
                  ),
                );
              },
            ),
            
            SizedBox(width: 20.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AI Assistant Active',
                    style: GoogleFonts.orbitron(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Neural processing: 99.7% efficiency',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  Text(
                    'Learning from your conversations...',
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIFeatureCard(
    String title,
    IconData icon,
    List<Color> gradient,
    bool isDarkMode,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 15,
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
          gradient[0].withOpacity(0.5),
          gradient[1].withOpacity(0.3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: gradient),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().scale(duration: 200.ms);
  }

  Widget _buildHolographicProfileCard(bool isDarkMode) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 150.h,
      borderRadius: 25,
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
          Color(0xFFFFD700).withOpacity(0.3),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Row(
          children: [
            // Profile avatar with holographic effect
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                ),
                border: Border.all(
                  color: Color(0xFFFFD700),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'U',
                  style: GoogleFonts.orbitron(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat()).shimmer(
              duration: 3000.ms,
              color: Color(0xFFFFD700).withOpacity(0.5),
            ),
            
            SizedBox(width: 24.w),
            
            // Profile info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Color(0xFF00FFFF), Color(0xFFFFD700)],
                    ).createShader(bounds),
                    child: Text(
                      'Quantum User',
                      style: GoogleFonts.orbitron(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '@quantumuser',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Color(0xFF4ECDC4),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        size: 12.sp,
                        color: Color(0xFF00FFFF),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Quantum Secured',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: Color(0xFF00FFFF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    String title,
    IconData icon,
    Color color,
    bool isDarkMode,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 60.h,
        borderRadius: 15,
        blur: 20,
        alignment: Alignment.center,
        border: 1,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.04),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            color.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color.withOpacity(0.7),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    ).animate().scale(duration: 200.ms);
  }

  Widget _buildFuturisticNavigation(bool isDarkMode) {
    return Positioned(
      bottom: 30.h,
      left: 20.w,
      right: 20.w,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80.h,
        borderRadius: 40,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            Color(0xFF00FFFF).withOpacity(0.6),
            Color(0xFFFFD700).withOpacity(0.4),
            Colors.transparent,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_navItems.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [Color(0xFF00FFFF), Color(0xFF4ECDC4)],
                        )
                      : null,
                  color: isSelected ? null : Colors.transparent,
                ),
                child: Icon(
                  _navIcons[index],
                  color: isSelected ? Colors.white : Color(0xFF00FFFF),
                  size: isSelected ? 28.sp : 24.sp,
                ),
              ).animate().scale(
                duration: 200.ms,
                curve: Curves.easeInOut,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFloatingActions(bool isDarkMode) {
    return Positioned(
      bottom: 120.h,
      right: 20.w,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: "camera",
            backgroundColor: Color(0xFFFFD700),
            onPressed: () {},
            child: Icon(Icons.camera_alt, color: Colors.white),
          ).animate().scale(
            delay: 200.ms,
            duration: 300.ms,
          ),
          
          SizedBox(height: 16.h),
          
          FloatingActionButton(
            heroTag: "add",
            backgroundColor: Color(0xFF00FFFF),
            onPressed: () {},
            child: Icon(Icons.add, color: Colors.white),
          ).animate().scale(
            delay: 100.ms,
            duration: 300.ms,
          ),
        ],
      ),
    );
  }

  Widget _buildAIAssistantOverlay(bool isDarkMode) {
    return Positioned(
      top: 150.h,
      left: 20.w,
      child: GlassmorphicContainer(
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
            Color(0xFFFFD700).withOpacity(0.5),
            Colors.transparent,
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.psychology,
              color: Color(0xFFFFD700),
              size: 24.sp,
            ),
            Positioned(
              top: 5.h,
              right: 5.w,
              child: Container(
                width: 8.w,
                height: 8.w,
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

  Widget _buildHolographicEffects(bool isDarkMode) {
    return AnimatedBuilder(
      animation: _hologramController,
      builder: (context, child) {
        return Stack(
          children: [
            // Corner holograms
            ...List.generate(4, (index) {
              final corners = [
                Offset(30.w, 200.h),
                Offset(MediaQuery.of(context).size.width - 30.w, 250.h),
                Offset(40.w, MediaQuery.of(context).size.height - 250.h),
                Offset(MediaQuery.of(context).size.width - 40.w, MediaQuery.of(context).size.height - 300.h),
              ];
              
              return Positioned(
                left: corners[index].dx,
                top: corners[index].dy,
                child: Transform.rotate(
                  angle: _hologramController.value * 2 * 3.14159 + (index * 1.57),
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: [
                          Color(0xFF00FFFF),
                          Color(0xFF4ECDC4),
                          Color(0xFFFFD700),
                          Color(0xFF44A08D),
                        ][index].withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class HomeNeuralPainter extends CustomPainter {
  final double animationValue;
  final bool isDarkMode;

  HomeNeuralPainter(this.animationValue, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDarkMode ? Colors.white : Colors.black).withOpacity(0.05)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw subtle neural network
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 5; j++) {
        final x = (size.width / 7) * i;
        final y = (size.height / 4) * j;
        
        // Add subtle wave motion
        final waveOffset = 15 * math.sin(animationValue * 2 + i * 0.3 + j * 0.4);
        
        // Draw connections
        if (i < 7) {
          canvas.drawLine(
            Offset(x + waveOffset, y),
            Offset(x + size.width / 7, y),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}