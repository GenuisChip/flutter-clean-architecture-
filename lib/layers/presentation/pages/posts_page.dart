import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/posts_cubit.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PostsCubit>().getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PostsCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: cubit.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                label: Text("Search"),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
          BlocBuilder<PostsCubit, PostsState>(builder: ((context, state) {
            if (state is PostsSearch) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text("Searching...")
                    ],
                  ),
                ),
              );
            }
            if (state is PostsLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is PostsFetched) {
              if (!state.posts.isSuccess) {
                return const Center(
                  child: Text("Error Occurred"),
                );
              } else {
                final posts = state.posts.data;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: cubit.getAllPosts,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final post = posts![index];
                        return ListTile(
                          leading: Text(post.id.toString()),
                          title: Text(post.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post.body),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.thumb_up),
                                  const SizedBox(width: 5),
                                  Text(post.reactions.toString()),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: ((context, index) => const Divider()),
                      itemCount: posts!.length,
                    ),
                  ),
                );
              }
            }
            return Text(state.toString());
          }))
        ],
      ),
    );
  }
}
