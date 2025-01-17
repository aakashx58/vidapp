import 'package:hive/hive.dart';

part 'comment_model.g.dart'; // Make sure to generate this file

@HiveType(typeId: 0) // Assign a unique type ID for Hive
class CommentModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String videoId;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String text;

  @HiveField(4)
  final String avatar;

  @HiveField(5)
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.videoId,
    required this.username,
    required this.text,
    required this.avatar,
    required this.timestamp,
  });

  /// Converts the model into a Map (for potential use in APIs or logs).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'videoId': videoId,
      'username': username,
      'text': text,
      'avatar': avatar,
      'timestamp': timestamp.toIso8601String(),
      'time': _getTimeAgo(),
    };
  }

  /// Factory method to create a CommentModel from a Map (useful for Hive or APIs).
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] ?? '',
      videoId: map['videoId'] ?? '',
      username: map['username'] ?? '',
      text: map['text'] ?? '',
      avatar: map['avatar'] ?? '',
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  /// Calculates time elapsed since the comment was posted.
  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
