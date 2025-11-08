import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_theme.dart';

enum ButtonVariant {
  filled,
  outline,
  gradient,
  glassmorphic,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final Color? customColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.customColor,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _animationController.reverse();
      widget.onPressed?.call();
    }
  }

  void _handleTapCancel() {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  double get _buttonHeight {
    if (widget.height != null) return widget.height!;
    switch (widget.size) {
      case ButtonSize.small:
        return 40.h;
      case ButtonSize.medium:
        return 50.h;
      case ButtonSize.large:
        return 60.h;
    }
  }

  double get _fontSize {
    switch (widget.size) {
      case ButtonSize.small:
        return 14.sp;
      case ButtonSize.medium:
        return 16.sp;
      case ButtonSize.large:
        return 18.sp;
    }
  }

  EdgeInsetsGeometry get _buttonPadding {
    if (widget.padding != null) return widget.padding!;
    switch (widget.size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h);
      case ButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h);
      case ButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: _buttonHeight,
      margin: widget.margin,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: _getButtonDecoration(),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: _buttonPadding,
                    child: _buildButtonContent(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration _getButtonDecoration() {
    final isDisabled = widget.isDisabled || widget.isLoading;
    
    switch (widget.variant) {
      case ButtonVariant.filled:
        return BoxDecoration(
          color: isDisabled
              ? Colors.grey.withOpacity(0.3)
              : widget.customColor ?? AppTheme.primaryAqua,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: (widget.customColor ?? AppTheme.primaryAqua)
                        .withOpacity(_isPressed ? 0.3 : 0.5),
                    blurRadius: _isPressed ? 8 : 15,
                    offset: Offset(0, _isPressed ? 2 : 5),
                    spreadRadius: _isPressed ? 0 : 2,
                  ),
                ],
        );

      case ButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: isDisabled
                ? Colors.grey.withOpacity(0.3)
                : widget.customColor ?? AppTheme.primaryAqua,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
        );

      case ButtonVariant.gradient:
        return BoxDecoration(
          gradient: isDisabled
              ? LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.3),
                    Colors.grey.withOpacity(0.2),
                  ],
                )
              : AppTheme.aquaGradient,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: AppTheme.primaryAqua.withOpacity(_isPressed ? 0.3 : 0.6),
                    blurRadius: _isPressed ? 10 : 20,
                    offset: Offset(0, _isPressed ? 2 : 8),
                    spreadRadius: _isPressed ? 0 : 3,
                  ),
                ],
        );

      case ButtonVariant.glassmorphic:
        return BoxDecoration(
          color: Colors.white.withOpacity(isDisabled ? 0.1 : 0.2),
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 16.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        );
    }
  }

  Widget _buildButtonContent() {
    final isDisabled = widget.isDisabled || widget.isLoading;
    Color textColor;

    switch (widget.variant) {
      case ButtonVariant.filled:
      case ButtonVariant.gradient:
        textColor = isDisabled ? Colors.grey : Colors.black;
        break;
      case ButtonVariant.outline:
      case ButtonVariant.glassmorphic:
        textColor = isDisabled
            ? Colors.grey
            : widget.customColor ?? AppTheme.primaryAqua;
        break;
    }

    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 20.w,
          height: 20.h,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(textColor),
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            color: textColor,
            size: _fontSize + 2,
          ),
          SizedBox(width: 8.w),
        ],
        Text(
          widget.text,
          style: TextStyle(
            color: textColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// Quick access buttons for common use cases
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      width: width,
      variant: ButtonVariant.gradient,
      size: ButtonSize.medium,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      isLoading: isLoading,
      width: width,
      variant: ButtonVariant.outline,
      size: ButtonSize.medium,
    );
  }
}