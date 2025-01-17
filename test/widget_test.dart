import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:video_feed/features/comment/model/comment_model.dart';
import 'package:video_feed/main.dart';

void main() {
  testWidgets('Comment box test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      commentsBox: Hive.box<CommentModel>('comments'),
    ));

    // Verify that the comment box is present.
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the send button is present.
    expect(find.byIcon(Icons.send), findsOneWidget);

    // Enter text into the comment box.
    final commentField = find.byType(TextField);
    await tester.enterText(commentField, 'This is a test comment');

    // Verify that the text has been entered into the comment box.
    expect(find.text('This is a test comment'), findsOneWidget);

    // Tap the send button and trigger a frame.
    await tester.tap(find.byIcon(Icons.send));
    await tester.pump();

    // Verify that the comment has been added to the list (adjust based on your implementation).
    // You need to replace 'Expected Result After Send' with what you expect after sending the comment.
    expect(find.text('Expected Result After Send'), findsOneWidget);
  });
}
