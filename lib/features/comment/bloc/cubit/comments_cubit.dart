import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  // Map to store comments for each video
  final Map<String, List<Map<String, String>>> _videoComments = {};

  CommentsCubit() : super(CommentsInitial());

  void loadComments(String videoId) {
    // Load existing comments for the specific videoId
    final comments = _videoComments[videoId] ?? [];
    emit(CommentsUpdated(comments));
  }

  void addComment(String videoId, String username, String text) {
    // Create a new comment
    final newComment = {
      'username': username,
      'text': text,
      'avatar': '', // Placeholder for avatar URL
      'time': 'Just now',
    };

    // Add the new comment to the video comments list
    if (_videoComments.containsKey(videoId)) {
      _videoComments[videoId]!.insert(0, newComment);
    } else {
      _videoComments[videoId] = [newComment];
    }

    // Emit the updated comments for that video
    emit(CommentsUpdated(_videoComments[videoId]!));
  }
}
