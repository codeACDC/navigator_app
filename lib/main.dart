import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigator_app_2/navigator_bloc/navigator_cubit.dart';
import 'package:navigator_app_2/navigator_bloc/navigator_post_cubit.dart';
import 'package:navigator_app_2/screens/navigator_main_page.dart';

void main() => runApp(const NavigatorApp());

class NavigatorApp extends StatelessWidget {
  const NavigatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigatorCubit>(
            create: (BuildContext context) => NavigatorCubit()..getLocation()),
        BlocProvider<NavigatorPostCubit>(
            create: (BuildContext context) => NavigatorPostCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: NavigatorMainPage(),
      ),
    );
  }
}
