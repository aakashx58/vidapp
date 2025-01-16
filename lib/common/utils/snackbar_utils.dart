import 'package:flutter/material.dart';
import 'package:video_feed/common/extension/text_theme_extension.dart';
import 'package:video_feed/styles/app_colors.dart';

class SnackBarUtils {
  SnackBarUtils._();

  static void showCustomSnackBar(
      {required BuildContext context, required String content}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: kBottomNavigationBarHeight + 16,
        left: 16,
        right: 16,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Start below the screen
            end: Offset.zero, // End at the original position
          ).animate(
            CurvedAnimation(
              parent: AnimationController(
                vsync: Navigator.of(context),
                duration: const Duration(milliseconds: 300),
              )..forward(),
              curve: Curves.easeInOut,
            ),
          ),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(4),
            color: AppColors.grey800,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: context.bodyMedium?.copyWith(
                        color: const Color(0xFFF5EFF7),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Automatically remove the snackbar after the duration
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  static void showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.grey800,
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        animation: CurvedAnimation(
            parent: kAlwaysCompleteAnimation, curve: Curves.easeInOut),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        content: Text(
          content,
          style: context.bodyMedium?.copyWith(
            color: const Color(0xFFF5EFF7),
          ),
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            if (context.mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          },
        ),
      ),
    );
  }
}

class LoadingSnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color progressColor;
  final Duration duration;

  const LoadingSnackbar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.black87,
    this.progressColor = Colors.blue,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.black87,
    Color progressColor = Colors.blue,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: LoadingSnackbar(
          message: message,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
          duration: duration,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage:
void showLoadingMessage(BuildContext context) {
  LoadingSnackbar.show(
    context,
    'Loading your data...',
    backgroundColor: Colors.black87,
    progressColor: Colors.blue,
    duration: const Duration(seconds: 2),
  );
}
