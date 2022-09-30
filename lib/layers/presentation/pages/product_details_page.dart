import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/product_details_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/products_cubit.dart';

class ProductDetailsPage extends StatefulWidget {
  final int id;
  const ProductDetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductDetailsCubit cubit;

  @override
  void dispose() {
    cubit.resetState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cubit = context.read<ProductDetailsCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Column(
        children: [
          BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsInitial) {
                cubit.getProductById(widget.id);
              }
              if (state is ProductDetailsLoading ||
                  state is ProductDetailsInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ProductDetailsSuccess) {
                final prod = state;
                return Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 300,
                        child: PageView(
                          children: [
                            for (final url in prod.product.images)
                              Image.network(url)
                          ],
                        ),
                      ),
                      Center(
                        child: Text(
                          prod.product.title,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          showCartDialog(context);
                        },
                        child: const Text("Add To Cart"),
                      )
                    ],
                  ),
                );
              } else if (state is Failed) {
                return const Text("Failed To Fetch");
              } else {
                return const Text("Unknown State");
              }
            },
            listener: (context, state) {},
          ),
        ],
      ),
    );
  }

  void showCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add To Cart"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [Text("Added To Cart")],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Ok"))
          ],
        );
      },
    );
  }
}
