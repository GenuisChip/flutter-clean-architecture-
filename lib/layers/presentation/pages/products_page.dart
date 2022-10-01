import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/products_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/pages/product_details_page.dart';
import 'package:products_clean_architecture/layers/presentation/pages/users_page.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
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
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UsersPage(),
                ),
              );
            },
            child: const Text("Users"),
          ),
          BlocConsumer<ProductsCubit, ProductsState>(
            listener: (context, state) {
              if (state is Failed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.response.statusCode.toString())));
              }
            },
            builder: (context, state) {
              final productsCubit = context.read<ProductsCubit>();

              if (state is ProductsInitial) {
                productsCubit.getAllProducts();
              }
              if (state is Loading || state is ProductsInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProductSearch) {
                return Column(
                  children: const [
                    CircularProgressIndicator(),
                    Text("Searching"),
                  ],
                );
              }
              if (state is Success) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await productsCubit.getAllProducts();
                    },
                    child: ListView.separated(
                      separatorBuilder: (_, i) {
                        return const Divider();
                      },
                      itemCount: state.products.length,
                      itemBuilder: (context, i) {
                        final item = state.products[i];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(id: item.id),
                              ),
                            );
                          },
                          leading: Image.network(
                            item.thumbnail,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.title),
                          subtitle: Text(item.description),
                          trailing: Text("${item.price}\$"),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const Text("Unknown error");
              }
            },
          )
        ],
      ),
    );
  }
}
