import 'package:flutter/material.dart';
import 'package:video_feed/common/extension/text_theme_extension.dart';
import 'package:video_feed/styles/app_colors.dart';

class TPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isBusy;
  final bool isDisable;
  final Color? backgroundColor;
  final double? borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final bool isMin;

  const TPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isBusy = false,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.isDisable = false,
    this.isMin = false,
    this.height = 60,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isBusy ? 0.4 : 1,
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDisable
                ? AppColors.grey500
                : backgroundColor ?? AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
            ),
          ),
          onPressed: isDisable
              ? null
              : isBusy
                  ? () {}
                  : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: isMin ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (isBusy) ...[
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                    strokeWidth: 2.2,
                  ),
                ),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Text(
                  label,
                  style: context.titleMedium?.copyWith(
                    fontSize: 18,
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
