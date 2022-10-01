import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/users_cubit.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    context.read<UsersCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: Column(
        children: [
          BlocBuilder<UsersCubit, UsersState>(
            builder: ((context, state) {
              if (state is UsersLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UsersFinished) {
                final users = state.users.data!;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: cubit.getAllUsers,
                    child: ListView.separated(
                      itemBuilder: (_, i) {
                        final item = users[i];
                        return ListTile(
                          leading: Image.network(
                            item.image,
                            width: 80,
                          ),
                          title: Text(item.firstName),
                          subtitle: Text(item.email),
                          trailing: Text("${item.age}yrs"),
                        );
                      },
                      separatorBuilder: (_, i) => const Divider(),
                      itemCount: users.length,
                    ),
                  ),
                );
              } else {
                return const Text("Can't load data");
              }
            }),
          ),
        ],
      ),
    );
  }
}
