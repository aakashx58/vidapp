import 'package:flutter/material.dart';
import 'package:video_feed/common/extension/text_theme_extension.dart';
import 'package:video_feed/components/button/t_primary_button.dart';
import 'package:video_feed/styles/app_colors.dart';

class DialogUtils {
  static Future<bool?> confirmationDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String positiveLabel,
    required String cancelLabel,
    Color? cancelButtonColor,
    Color? positiveButtonColor,
  }) async {
    return await showDialog<bool?>(
      context: context,
      builder: (context) {
        return Dialog(
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          insetPadding: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: context.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: context.bodyMedium?.copyWith(
                    color: AppColors.grey500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TPrimaryButton(
                        height: 50,
                        label: cancelLabel,
                        backgroundColor: cancelButtonColor ?? AppColors.grey400,
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TPrimaryButton(
                        height: 50,
                        label: positiveLabel,
                        backgroundColor:
                            positiveButtonColor ?? AppColors.primary,
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
