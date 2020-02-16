import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/AnimationMenu/slide_bar.dart';
import 'package:myapp/SplashScreen/splash_screen.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';

class SplashScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //create: (context) => NavigationBloc(),
          Stack(
        children: <Widget>[SplashScreen()],
      ),
    );
  }
}
