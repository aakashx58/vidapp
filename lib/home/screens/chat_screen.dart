import 'package:flutter/material.dart';
import 'package:video_feed/common/extra/reusable_info_screen.dart';
import 'package:video_feed/styles/app_assets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReusableInfoScreen(
      imagePath: AppAssets.image3,
      title: "Chat",
      subtitle: "Connect with your friends through chat!",
    );
  }
}
