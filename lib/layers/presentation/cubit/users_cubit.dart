import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_clean_architecture/commons/network/api_manager/api_manager.dart';
import 'package:products_clean_architecture/layers/domain/entities/user_entity.dart';
import 'package:products_clean_architecture/layers/domain/repository/users_repo_if.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepoIF usersRepo;
  UsersCubit({required this.usersRepo}) : super(UsersInitial());

  Future<void> getAllUsers() async {
    emit(UsersLoading());
    final res = await usersRepo.getAllUsers();
    emit(UsersFinished(users: res));
  }
}
