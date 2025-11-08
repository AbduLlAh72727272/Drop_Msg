import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  late AnimationController _animationController;
  late AnimationController _timerAnimationController;
  
  bool _isLoading = false;
  bool _isResending = false;
  int _resendCountdown = 60;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _timerAnimationController = AnimationController(
      duration: const Duration(seconds: 60),
      vsync: this,
    );
    
    _animationController.forward();
    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _animationController.dispose();
    _timerAnimationController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _timerAnimationController.forward();
    _updateCountdown();
  }

  void _updateCountdown() async {
    for (int i = 60; i >= 0; i--) {
      if (mounted) {
        setState(() => _resendCountdown = i);
        await Future.delayed(const Duration(seconds: 1));
      }
    }
  }

  Future<void> _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() => _isLoading = false);
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.profileSetup);
    }
  }

  Future<void> _resendOTP() async {
    if (_resendCountdown > 0) return;
    
    setState(() => _isResending = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isResending = false;
      _resendCountdown = 60;
    });
    
    _timerAnimationController.reset();
    _startResendTimer();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Verification code sent successfully!'),
          backgroundColor: AppTheme.primaryAqua,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
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
                      _buildVerificationIcon(),
                      SizedBox(height: 40.h),
                      _buildTitle(),
                      SizedBox(height: 16.h),
                      _buildSubtitle(),
                      SizedBox(height: 50.h),
                      _buildOTPForm(),
                      SizedBox(height: 40.h),
                      _buildVerifyButton(),
                      SizedBox(height: 30.h),
                      _buildResendSection(),
                      const Spacer(),
                      _buildChangeNumberOption(),
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
          'Verify Phone',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.primaryAqua,
          ),
        ),
        const Spacer(),
        SizedBox(width: 48.w),
      ],
    );
  }

  Widget _buildVerificationIcon() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.aquaGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryAqua.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Icon(
        Icons.sms_outlined,
        size: 50.sp,
        color: Colors.white,
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
          color: Colors.white.withOpacity(0.3),
        );
  }

  Widget _buildTitle() {
    return Text(
      'Enter Verification Code',
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
    return Column(
      children: [
        Text(
          'We\'ve sent a 6-digit verification code to',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          widget.phoneNumber,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryAqua,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 500))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildOTPForm() {
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryAqua.withOpacity(0.3),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white.withOpacity(0.1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.primaryAqua,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white.withOpacity(0.2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryAqua.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        gradient: AppTheme.aquaGradient,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryAqua.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Pinput(
            controller: _otpController,
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Please enter the complete verification code';
              }
              return null;
            },
            onCompleted: (pin) {
              HapticFeedback.selectionClick();
              _verifyOTP();
            },
          )
              .animate()
              .fadeIn(delay: const Duration(milliseconds: 700))
              .slideY(begin: 0.3, end: 0),
              
          SizedBox(height: 20.h),
          
          Text(
            'Enter the 6-digit code sent to your phone',
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    return PrimaryButton(
      text: 'Verify & Continue',
      onPressed: _isLoading ? null : _verifyOTP,
      isLoading: _isLoading,
      width: double.infinity,
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 900))
        .slideY(begin: 0.3, end: 0);
  }

  Widget _buildResendSection() {
    return Column(
      children: [
        Text(
          'Didn\'t receive the code?',
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 8.h),
        
        if (_resendCountdown > 0)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                size: 16.w,
                color: AppTheme.secondaryAqua,
              ),
              SizedBox(width: 4.w),
              Text(
                'Resend in ${_resendCountdown}s',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppTheme.secondaryAqua,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        else
          GestureDetector(
            onTap: _resendOTP,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppTheme.primaryAqua.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isResending)
                    SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.primaryAqua,
                      ),
                    )
                  else
                    Icon(
                      Icons.refresh,
                      size: 16.w,
                      color: AppTheme.primaryAqua,
                    ),
                  SizedBox(width: 8.w),
                  Text(
                    'Resend Code',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.primaryAqua,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 1100));
  }

  Widget _buildChangeNumberOption() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Text(
        'Change phone number',
        style: TextStyle(
          fontSize: 14.sp,
          color: AppTheme.primaryAqua,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    )
        .animate()
        .fadeIn(delay: const Duration(milliseconds: 1300));
  }
}