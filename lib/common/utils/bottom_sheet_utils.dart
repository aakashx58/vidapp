// ignore_for_file: dead_code

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';
import 'package:video_feed/features/comment/bot/comment_bot.dart';

class BottomSheetUtils {
  static void showCommentsSheet({
    required BuildContext context,
    required String videoId,
  }) {
    final commentController = TextEditingController();
    Timer? _timer;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<CommentsCubit>(context)..loadComments(videoId),
          child: DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (_, controller) {
              return Column(
                children: [
                  AppBar(
                    title: const Text('Comments'),
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _timer?.cancel();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<CommentsCubit, CommentsState>(
                      builder: (context, state) {
                        if (state is CommentsUpdated) {
                          return ListView.builder(
                            controller: controller,
                            itemCount: state.comments.length,
                            itemBuilder: (context, index) {
                              final comment = state.comments[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(comment['avatar'] ?? ''),
                                ),
                                title: Text(comment['username'] ?? ''),
                                subtitle: Text(comment['text'] ?? ''),
                                trailing: Text(comment['time'] ?? ''),
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: 'Add a comment...',
                            ),
                            onChanged: (text) {
                              _timer?.cancel();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (commentController.text.isNotEmpty) {
                              context.read<CommentsCubit>().addComment(
                                  videoId, 'You', commentController.text);

                              commentController.clear();

                              _timer?.cancel();

                              CommentBot.startCommentBot(context, videoId);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
