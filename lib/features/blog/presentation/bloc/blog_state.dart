part of 'blog_bloc.dart';

final class BlogFailure extends BlogState {
  final String error;
  BlogFailure(this.error);
}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogsListSuccess extends BlogState {
  final List<Blog> blogs;
  BlogsListSuccess(this.blogs);
}

@immutable
sealed class BlogState {}

final class BlogUploadSuccess extends BlogState {}
