import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app/bloc/product_bloc.dart';
import 'package:market_app/screen/home_page.dart';
import 'package:market_app/screen/landing_page.dart';
import 'package:market_app/service.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ProductBloc(productsRepository: ProductService()),
      child: Sizer(builder: (context, orientation, deviceType) => MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework',
      theme: ThemeData(
        fontFamily: 'Prompt',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
