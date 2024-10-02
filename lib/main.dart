import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/delivery_bloc.dart';
import 'pages/delivery_home_page.dart';
import 'styles/app_styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AppStyles.backgroundAppColor,
        snackBarTheme: AppStyles.snackBarTheme,
      ),
      home: BlocProvider(
        create: (context) => DeliveryBloc(),
        child: DeliveryHomePage(),
      ),
    );
  }
}
