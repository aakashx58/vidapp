import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_feed/common/extension/text_theme_extension.dart';
import 'package:video_feed/common/utils/snackbar_utils.dart';
import 'package:video_feed/components/button/t_primary_button.dart';
import 'package:video_feed/components/utils/dialog_utils.dart';
import 'package:video_feed/styles/app_assets.dart';
import 'package:video_feed/styles/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  ProfileScreen({super.key});

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 108,
                  height: 108,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.avatar),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(
                      side: BorderSide(
                        width: 3.40,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: AppColors.grey100,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 2,
                  right: 8,
                  child:
                      Icon(Icons.verified, color: AppColors.green500, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Aakash Rajbanshi",
              style: context.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(color: AppColors.shadow),
            ),
            const SizedBox(height: 32),
            _buildInfoRow("Location", "Kathmandu, Nepal"),
            _buildInfoRow("Mobile No", "(+977) 9816370280"),
            _buildInfoRow("Email", FirebaseAuth.instance.currentUser!.email!),
            const Spacer(),
            TPrimaryButton(
              label: 'Log Out',
              isBusy: false,
              onPressed: () async {
                final shouldLogout = await DialogUtils.confirmationDialog(
                  context: context,
                  title: 'Log Out',
                  subtitle: 'Are you sure you want to log out?',
                  positiveLabel: 'Yes',
                  cancelLabel: 'Cancel',
                );
                if (shouldLogout ?? false) {
                  try {
                    await signout();
                  } catch (e) {
                    SnackBarUtils.showCustomSnackBar(
                      context: context,
                      content: 'Something went wrong',
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.shadow),
          ),
          Text(value),
        ],
      ),
    );
  }
}
