import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:weatherapp/screens/directing_view.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/utils/colors.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DirectingView()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bigCardColorNight,
        body: const Center(
          child: SizedBox(
              width: 200,
              height: 200,
              child: Image(
                image: Svg('assets/images/weather.svg'),
                fit: BoxFit.contain,
              )),
        ));
  }
}
