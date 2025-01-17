import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';

class CommentBot {
  static void startCommentBot(BuildContext context, String videoId) {
    Timer(const Duration(seconds: 5), () {
      final randomComment = _generateRandomComment();
      context.read<CommentsCubit>().addComment(videoId, 'Bot', randomComment);
    });
  }

  static String _generateRandomComment() {
    final comments = [
      'Nice video!',
      'Loved this content!',
      'Very informative!',
      'Keep up the good work!',
      'I learned a lot from this!',
      'This is amazing!',
      'Can’t wait for more!',
      'Such a great explanation!',
      'Interesting perspective!',
      'Thanks for sharing this!',
    ];
    final randomIndex =
        (comments.length * (DateTime.now().millisecondsSinceEpoch % 100) / 100)
                .floor() %
            comments.length;
    return comments[randomIndex];
  }
}
