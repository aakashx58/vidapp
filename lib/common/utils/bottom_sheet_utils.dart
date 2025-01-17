// ignore_for_file: dead_code, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:video_feed/components/textfield/t_text_field.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';
import 'package:video_feed/features/comment/bot/comment_bot.dart';
import 'package:video_feed/styles/app_assets.dart';
import 'package:video_feed/styles/app_colors.dart';

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<CommentsCubit>(context)..loadComments(videoId),
          child: DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (_, controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: Text(
                      'Comments',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
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
                                leading: const CircleAvatar(
                                  radius: 18,
                                  backgroundImage: AssetImage(AppAssets.avatar),
                                ),
                                title: Text(comment.username,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                subtitle: Text(comment.text,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                trailing: Text(
                                  comment.timestamp != null
                                      ? DateFormat('yyyy-MM-dd – kk:mm')
                                          .format(comment.timestamp)
                                      : '',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
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
                      bottom: MediaQuery.of(context).viewInsets.bottom + 8.0,
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TTextField(
                            textEditingController: commentController,
                            hint: 'Add a comment...',
                            onChanged: (text) {
                              _timer?.cancel();
                            },
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.send, color: AppColors.primary),
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
