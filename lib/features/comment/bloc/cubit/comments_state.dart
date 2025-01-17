part of 'comments_cubit.dart';

@immutable
sealed class CommentsState {}

final class CommentsInitial extends CommentsState {}

final class CommentsUpdated extends CommentsState {
  final List<Map<String, String>> comments;

  CommentsUpdated(this.comments);
}
