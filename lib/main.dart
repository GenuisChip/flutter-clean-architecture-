import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/posts_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/product_details_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/products_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/cubit/users_cubit.dart';
import 'package:products_clean_architecture/layers/presentation/pages/products_page.dart';
import 'dependencies.dart' as di;

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(products: di.sl()),
        ),
        BlocProvider(
          create: (context) => ProductDetailsCubit(products: di.sl()),
        ),
        BlocProvider(
          create: (context) => UsersCubit(usersRepo: di.sl()),
        ),
        BlocProvider(
          create: (context) => PostsCubit(posts: di.sl()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const ProductsPage(),
      ),
    );
  }
}
