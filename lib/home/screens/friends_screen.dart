import 'package:flutter/material.dart';
import 'package:video_feed/common/extra/reusable_info_screen.dart';
import 'package:video_feed/styles/app_assets.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReusableInfoScreen(
      imagePath: AppAssets.image1,
      title: "Friends",
      subtitle: "Stay connected with your friends!",
    );
  }
}
