part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSearch extends PostsState {}

class PostsFetched extends PostsState {
  final ApiManagerResponse<List<PostEntity>> posts;
  const PostsFetched({
    required this.posts,
  });
}
