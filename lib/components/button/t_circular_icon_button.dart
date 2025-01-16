import 'package:flutter/material.dart';

class TCircularIconButton extends StatelessWidget {
  final IconData iconData;
  final Color? iconColor;
  final VoidCallback onPressed;
  const TCircularIconButton(
      {super.key,
      required this.iconData,
      required this.onPressed,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      padding: const EdgeInsets.all(10),
      style: IconButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: iconColor ?? Theme.of(context).iconTheme.color,
      ),
    );
  }
}
