import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_feed/common/utils/snackbar_utils.dart';
import 'package:video_feed/components/button/t_primary_button.dart';
import 'package:video_feed/components/utils/dialog_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: TPrimaryButton(
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
        ),
      ),
    );
  }
}
