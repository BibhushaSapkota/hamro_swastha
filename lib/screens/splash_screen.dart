import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();
      final isWalthroughShown = prefs.getBool("isWalkthroughShown") ?? false;
      if (isWalthroughShown) {
        Navigator.pushReplacementNamed(context, "/choose_option");
      } else {
        Navigator.pushReplacementNamed(context, "/walkthrough");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: COLOR_SECONDARY));
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: screen.width,
            height: screen.height,
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/ic_logo.png",
                  height: 100,
                )),
                Positioned(
                  width: screen.width,
                  bottom: 30,
                  child: Text(
                    "Powered by Mero Health",
                    style: themeData.textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
