import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fabAnimationController;
  
  int _selectedIndex = 0;
  bool _isSearchActive = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fabAnimationController.dispose();
    _searchController.dispose();
    super.dispose();
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
              AppTheme.primaryAqua.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              if (_isSearchActive) _buildSearchBar(),
              _buildTabBar(),
              Expanded(child: _buildTabBarView()),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Profile Avatar
          GestureDetector(
            onTap: () {
              // Navigate to profile
            },
            child: Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.aquaGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryAqua.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          
          SizedBox(width: 12.w),
          
          // App Title
          Expanded(
            child: Text(
              'DropMsg',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Action buttons
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isSearchActive = !_isSearchActive;
                  });
                },
                icon: Icon(
                  _isSearchActive ? Icons.close : Icons.search,
                  color: AppTheme.primaryAqua,
                ),
              ),
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: AppTheme.primaryAqua,
                ),
                onSelected: (value) {
                  // Handle menu actions
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'new_group',
                    child: Row(
                      children: [
                        Icon(Icons.group_add),
                        SizedBox(width: 12),
                        Text('New group'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'starred',
                    child: Row(
                      children: [
                        Icon(Icons.star),
                        SizedBox(width: 12),
                        Text('Starred messages'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 12),
                        Text('Settings'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 500))
        .slideY(begin: -0.5, end: 0);
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GlassmorphicContainer(
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
            AppTheme.primaryAqua.withOpacity(0.5),
            AppTheme.secondaryAqua.withOpacity(0.3),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search messages, contacts...',
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            hintStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: AppTheme.primaryAqua,
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: const Duration(milliseconds: 300))
        .slideY(begin: -0.3, end: 0);
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.white.withOpacity(0.1),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          gradient: AppTheme.aquaGradient,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
        ),
        tabs: const [
          Tab(text: 'CHATS'),
          Tab(text: 'STATUS'),
          Tab(text: 'CALLS'),
          Tab(text: 'AI'),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 200))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildChatsTab(),
        _buildStatusTab(),
        _buildCallsTab(),
        _buildAITab(),
      ],
    );
  }

  Widget _buildChatsTab() {
    final chats = _getDummyChats();
    
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(chat, index);
      },
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80.h,
        borderRadius: 16,
        blur: 20,
        alignment: Alignment.center,
        border: 1.5,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            AppTheme.primaryAqua.withOpacity(0.3),
            AppTheme.secondaryAqua.withOpacity(0.2),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          leading: Stack(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: AppTheme.primaryAqua,
                child: Text(
                  chat['name'][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              if (chat['isOnline'])
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  chat['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              if (chat['unreadCount'] > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: AppTheme.aquaGradient,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    '${chat['unreadCount']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  chat['lastMessage'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                chat['time'],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppTheme.secondaryAqua,
                ),
              ),
            ],
          ),
          onTap: () {
            // Navigate to chat screen
          },
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: index * 100))
        .fadeIn(duration: const Duration(milliseconds: 500))
        .slideX(begin: 0.3, end: 0);
  }

  Widget _buildStatusTab() {
    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        _buildMyStatusItem(),
        SizedBox(height: 16.h),
        Text(
          'Recent updates',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.h),
        ..._getDummyStatus().map((status) => _buildStatusItem(status)),
      ],
    );
  }

  Widget _buildMyStatusItem() {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 80.h,
      borderRadius: 16,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          AppTheme.primaryAqua.withOpacity(0.1),
          AppTheme.secondaryAqua.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          AppTheme.primaryAqua.withOpacity(0.5),
          AppTheme.secondaryAqua.withOpacity(0.3),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.aquaGradient,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 12.sp,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          'My status',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          'Tap to add status update',
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
          ),
        ),
        onTap: () {
          // Add status
        },
      ),
    );
  }

  Widget _buildStatusItem(Map<String, dynamic> status) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80.h,
        borderRadius: 16,
        blur: 20,
        alignment: Alignment.center,
        border: 1.5,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            AppTheme.metallicGold.withOpacity(0.3),
            AppTheme.metallicSilver.withOpacity(0.2),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryAqua,
                  AppTheme.secondaryAqua,
                ],
              ),
            ),
            padding: EdgeInsets.all(2.w),
            child: CircleAvatar(
              backgroundColor: AppTheme.metallicSilver,
              child: Text(
                status['name'][0],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ),
          title: Text(
            status['name'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          subtitle: Text(
            status['time'],
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
          ),
          onTap: () {
            // View status
          },
        ),
      ),
    );
  }

  Widget _buildCallsTab() {
    final calls = _getDummyCalls();
    
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: calls.length,
      itemBuilder: (context, index) {
        final call = calls[index];
        return _buildCallItem(call, index);
      },
    );
  }

  Widget _buildCallItem(Map<String, dynamic> call, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 80.h,
        borderRadius: 16,
        blur: 20,
        alignment: Alignment.center,
        border: 1.5,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [
            call['isMissed'] 
                ? Colors.red.withOpacity(0.3)
                : Colors.green.withOpacity(0.3),
            call['isMissed'] 
                ? Colors.red.withOpacity(0.2)
                : Colors.green.withOpacity(0.2),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          leading: CircleAvatar(
            radius: 25.r,
            backgroundColor: AppTheme.primaryAqua,
            child: Text(
              call['name'][0],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
          ),
          title: Text(
            call['name'],
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: call['isMissed'] ? Colors.red : null,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                call['isIncoming'] ? Icons.call_received : Icons.call_made,
                size: 16.sp,
                color: call['isMissed'] ? Colors.red : Colors.green,
              ),
              SizedBox(width: 4.w),
              Text(
                call['time'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              // Make call
            },
            icon: Icon(
              call['isVideo'] ? Icons.videocam : Icons.phone,
              color: AppTheme.primaryAqua,
            ),
          ),
          onTap: () {
            // Call details
          },
        ),
      ),
    );
  }

  Widget _buildAITab() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          GlassmorphicContainer(
            width: double.infinity,
            height: 120.h,
            borderRadius: 20,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              colors: [
                AppTheme.primaryAqua.withOpacity(0.1),
                AppTheme.metallicGold.withOpacity(0.1),
              ],
            ),
            borderGradient: AppTheme.metallicGradient,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.auto_awesome,
                  size: 40.sp,
                  color: AppTheme.metallicGold,
                ),
                SizedBox(height: 8.h),
                Text(
                  'AI Assistant',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.metallicGold,
                  ),
                ),
                Text(
                  'Powered by advanced AI',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              children: [
                _buildAIFeatureCard(
                  'Smart Replies',
                  Icons.reply,
                  'AI-generated responses',
                ),
                _buildAIFeatureCard(
                  'Translation',
                  Icons.translate,
                  'Real-time translation',
                ),
                _buildAIFeatureCard(
                  'Mood Analysis',
                  Icons.sentiment_satisfied,
                  'Emotion detection',
                ),
                _buildAIFeatureCard(
                  'Voice Assistant',
                  Icons.mic,
                  'Voice commands',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIFeatureCard(String title, IconData icon, String subtitle) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: double.infinity,
      borderRadius: 16,
      blur: 20,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.white.withOpacity(0.05),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [
          AppTheme.primaryAqua.withOpacity(0.3),
          AppTheme.metallicSilver.withOpacity(0.3),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32.sp,
            color: AppTheme.primaryAqua,
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return ScaleTransition(
      scale: _fabAnimationController,
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.aquaGradient,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryAqua.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              // New chat action
            },
            child: Icon(
              _selectedIndex == 0 
                  ? Icons.message 
                  : _selectedIndex == 1 
                    ? Icons.camera_alt
                    : Icons.phone,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDummyChats() {
    return [
      {
        'name': 'Alex Chen',
        'lastMessage': 'Hey! How\'s the new app coming along? 🚀',
        'time': '12:45 PM',
        'unreadCount': 2,
        'isOnline': true,
      },
      {
        'name': 'Sarah Johnson',
        'lastMessage': 'Thanks for sharing those design concepts!',
        'time': '11:30 AM',
        'unreadCount': 0,
        'isOnline': false,
      },
      {
        'name': 'Dev Team',
        'lastMessage': 'Meeting scheduled for 3 PM today',
        'time': '10:15 AM',
        'unreadCount': 5,
        'isOnline': true,
      },
      {
        'name': 'Emma Wilson',
        'lastMessage': 'The UI looks amazing! 😍',
        'time': 'Yesterday',
        'unreadCount': 1,
        'isOnline': true,
      },
      {
        'name': 'Mike Rodriguez',
        'lastMessage': 'Let\'s catch up soon',
        'time': 'Yesterday',
        'unreadCount': 0,
        'isOnline': false,
      },
    ];
  }

  List<Map<String, dynamic>> _getDummyStatus() {
    return [
      {
        'name': 'Alex Chen',
        'time': '5 minutes ago',
      },
      {
        'name': 'Sarah Johnson',
        'time': '1 hour ago',
      },
      {
        'name': 'Emma Wilson',
        'time': '3 hours ago',
      },
    ];
  }

  List<Map<String, dynamic>> _getDummyCalls() {
    return [
      {
        'name': 'Alex Chen',
        'time': '5 minutes ago',
        'isIncoming': true,
        'isMissed': false,
        'isVideo': true,
      },
      {
        'name': 'Sarah Johnson',
        'time': '1 hour ago',
        'isIncoming': false,
        'isMissed': false,
        'isVideo': false,
      },
      {
        'name': 'Mike Rodriguez',
        'time': '3 hours ago',
        'isIncoming': true,
        'isMissed': true,
        'isVideo': false,
      },
    ];
  }
}