part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersFinished extends UsersState {
  final ApiManagerResponse<List<UserEntity>> users;
  const UsersFinished({
    required this.users,
  });
}
