import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_clean_architecture/commons/handlers/debounce.dart';
import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';

import 'package:products_clean_architecture/layers/domain/usecases/posts_use_case.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsUseCase posts;
  final searchDebouncer = Debouncer(delay: const Duration(seconds: 1));

  PostsCubit({
    required this.posts,
  }) : super(PostsInitial());

  search(String text) async {
    if (text.trim().isEmpty) {
      return await getAllPosts();
    }
    if (text.trim().length < 3) return;
    searchDebouncer.debounce(() async {
      emit(PostsSearch());
      final res = await posts.search(text);
      emit(PostsFetched(posts: res));
    });
  }

  Future<void> getAllPosts() async {
    emit(PostsLoading());
    final res = await posts.getAllPosts();
    emit(PostsFetched(posts: res));
  }
}
