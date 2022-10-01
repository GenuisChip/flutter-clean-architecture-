import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:products_clean_architecture/commons/handlers/debounce.dart';
import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/users_repo_if.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepoIF usersRepo;
  final searchDebouncer = Debouncer(delay: const Duration(seconds: 1));
  UsersCubit({required this.usersRepo}) : super(UsersInitial());

  search(String text) async {
    if (text.trim().isEmpty) {
      return await getAllUsers();
    }
    if (text.trim().length < 3) return;
    searchDebouncer.debounce(() async {
      emit(UsersSearch());
      final res = await usersRepo.searchUser(text);
      emit(UsersFinished(users: res));
    });
  }

  Future<void> getAllUsers() async {
    emit(UsersLoading());
    final res = await usersRepo.getAllUsers();
    emit(UsersFinished(users: res));
  }
}
