import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/custom_button.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen>
    with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  late AnimationController _animationController;
  String _selectedCountryCode = '+1';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    final phoneNumber = _selectedCountryCode + _phoneController.text;
    
    if (mounted) {
      Navigator.pushNamed(
        context,
        AppRouter.otpVerification,
        arguments: phoneNumber,
      );
    }
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
              AppTheme.metallicSilver.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 40.h),
                      _buildLogo(),
                      SizedBox(height: 40.h),
                      _buildTitle(),
                      SizedBox(height: 16.h),
                      _buildSubtitle(),
                      SizedBox(height: 50.h),
                      _buildPhoneForm(),
                      SizedBox(height: 40.h),
                      _buildContinueButton(),
                      const Spacer(),
                      _buildPrivacyText(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: AppTheme.primaryAqua,
        ),
        const Spacer(),
        Text(
          'Phone Verification',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.primaryAqua,
          ),
        ),
        const Spacer(),
        SizedBox(width: 48.w), // Balance the back button
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryAqua.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
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
        .animate(controller: _animationController)
        .scale(
          begin: const Offset(0, 0),
          end: const Offset(1, 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
        )
        .shimmer(
          delay: const Duration(milliseconds: 700),
          duration: const Duration(milliseconds: 1000),
          color: AppTheme.primaryAqua.withOpacity(0.3),
        );
  }

  Widget _buildTitle() {
    return Text(
      'Enter Your Phone Number',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 24.sp,
      ),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 300))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildSubtitle() {
    return Text(
      'We\'ll send you a verification code to confirm your identity and secure your account.',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 14.sp,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 500))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildPhoneForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Phone input with glassmorphic design
          GlassmorphicContainer(
            width: double.infinity,
            height: 60.h,
            borderRadius: 16,
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
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryAqua.withOpacity(0.5),
                AppTheme.secondaryAqua.withOpacity(0.3),
              ],
            ),
            child: Row(
              children: [
                // Country code picker
                CountryCodePicker(
                  onChanged: (country) {
                    setState(() {
                      _selectedCountryCode = country.dialCode!;
                    });
                  },
                  initialSelection: 'US',
                  favorite: const ['+1', '+91', '+44', '+33', '+49'],
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  padding: EdgeInsets.zero,
                  textStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  dialogTextStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  searchStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                
                Container(
                  width: 1,
                  height: 30.h,
                  color: AppTheme.primaryAqua.withOpacity(0.3),
                ),
                
                SizedBox(width: 12.w),
                
                // Phone number input
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Phone number',
                      hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
                        fontSize: 16.sp,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 700))
              .slideY(begin: 0.3, end: 0),
              
          SizedBox(height: 20.h),
          
          // Info text
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16.w,
                color: AppTheme.secondaryAqua,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Standard messaging rates may apply',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return PrimaryButton(
      text: 'Send Verification Code',
      onPressed: _isLoading ? null : _sendOTP,
      isLoading: _isLoading,
      width: double.infinity,
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 900))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildPrivacyText() {
    return Text(
      'By continuing, you agree to our Terms of Service and Privacy Policy.',
      style: TextStyle(
        fontSize: 12.sp,
        color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
        height: 1.4,
      ),
      textAlign: TextAlign.center,
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 1100));
  }
}