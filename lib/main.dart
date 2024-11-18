import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/bloc/product_bloc.dart';
import 'package:market_app/screen/first_view.dart';
import 'package:market_app/service.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(Sizer(builder: (context, orientation, deviceType) => MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ProductBloc(productsRepository: ProductService()),
        child: const FirstView(),
      ),
    );
  }
}
