import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:video_feed/features/comment/model/comment_model.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final Box<CommentModel> _commentsBox;

  CommentsCubit(this._commentsBox) : super(CommentsInitial());

  void loadComments(String videoId) {
    // Load existing comments for the specific videoId from Hive
    final comments = _commentsBox.values
        .where((comment) => comment.videoId == videoId)
        .toList();

    emit(CommentsUpdated(comments)); // Emit the list of CommentModel directly
  }

  void addComment(String videoId, String username, String text) {
    // Create a new comment
    final newComment = CommentModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Unique ID
      videoId: videoId,
      username: username,
      text: text,
      avatar: '', // Placeholder for avatar URL
      timestamp: DateTime.now(),
    );

    // Save the new comment to Hive
    _commentsBox.add(newComment);

    // Emit the updated comments for that video
    loadComments(videoId);
  }
}
