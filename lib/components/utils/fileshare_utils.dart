import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileSharingUtil {
  static Future<void> shareLocalFile(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_video.mp4');

      await file.writeAsBytes(byteData.buffer.asUint8List());
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Shared Video',
      );
    } catch (e) {
      debugPrint('Error sharing local file: $e');
      rethrow;
    }
  }
}
