part of 'comments_cubit.dart';

@immutable
abstract class CommentsState {}

class CommentsInitial extends CommentsState {}

class CommentsUpdated extends CommentsState {
  final List<CommentModel> comments; // Change to List<CommentModel>

  CommentsUpdated(this.comments);
}
