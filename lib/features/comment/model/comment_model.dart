class CommentModel {
  final String id;
  final String videoId;
  final String username;
  final String text;
  final String avatar;
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.videoId,
    required this.username,
    required this.text,
    required this.avatar,
    required this.timestamp,
  });

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
