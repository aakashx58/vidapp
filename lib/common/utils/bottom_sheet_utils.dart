import 'package:flutter/material.dart';
import 'package:video_feed/styles/app_colors.dart';

class BottomSheetUtils {
  static Future<void> showCommentsSheet({
    required BuildContext context,
    required List<Map<String, String>> comments, // List of comments
    required void Function(String)
        onCommentSubmitted, // Callback for submitting comments
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        final TextEditingController _commentController =
            TextEditingController();

        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(comment['avatar'] ?? ''),
                        ),
                        title: Text(
                          comment['username'] ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          comment['text'] ?? '',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: Text(
                          comment['time'] ?? '',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Add a comment...',
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: AppColors.greycontainer,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.send, color: AppColors.primary),
                        onPressed: () {
                          if (_commentController.text.trim().isNotEmpty) {
                            onCommentSubmitted(_commentController.text.trim());
                            _commentController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
