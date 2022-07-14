import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app0/cubit/cubit.dart';
import 'package:todo_app0/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoAppCubit()..createDatabase(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

        ),
        home: HomeScreen (),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

