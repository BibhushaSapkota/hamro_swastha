import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class LoginPage extends StatelessWidget {
  final TapGestureRecognizer _gesturesRecongnizer = TapGestureRecognizer()
    ..onTap = () {
      debugPrint("Hello World");
    };

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
          body: SizedBox(
            height: screen.height,
            width: screen.width,
            child: Stack(
              children: [
                Image.asset(
                  "assets/images/ic_login_bg.png",
                  width: screen.width,
                  height: screen.height / 3,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  bottom: 0,
                  child: Image.asset("assets/images/ic_login_bottom.png",
                      width: screen.width, fit: BoxFit.fill),
                ),
                Positioned(
                    top: screen.height / 3 - 80,
                    height: screen.height - screen.height / 3 + 80,
                    width: screen.width,
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign In",
                              style:
                              TextStyle(color: COLOR_SECONDARY, fontSize: 30),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Username",
                              style: TextStyle(color: COLOR_GREY, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 16, height: 0.8, color: Colors.black54),
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Password",
                              style: themeData.textTheme.bodyText2
                                  ?.copyWith(color: COLOR_GREY, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 16, height: 0.8, color: Colors.black54),
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(text: TextSpan(
                                text: "Forgot your password? ",
                                style: TextStyle(color: COLOR_BLACK,fontSize: 16),
                                children: [
                                  TextSpan(text: "Click Here", style: TextStyle(color: COLOR_SECONDARY),
                                      recognizer: TapGestureRecognizer()..onTap=()=>{

                                      })
                                ]
                            ),),
                            SizedBox(height: 20,),
                            Center(
                              child: MaterialButton(
                                onPressed: () {},
                                color: COLOR_SECONDARY,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                minWidth: screen.width / 2,
                                height: 50,
                                child: const Text(
                                  "Sign In",
                                  style:
                                  TextStyle(color: COLOR_WHITE, fontSize: 18),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, "/login");
                                },
                                child: RichText(
                                    text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                        children: [
                                          TextSpan(text: "Don't have account? "),
                                          TextSpan(
                                              text: "Login",
                                              style: TextStyle(
                                                  color: COLOR_SECONDARY,
                                                  fontWeight: FontWeight.bold),
                                              recognizer: _gesturesRecongnizer)
                                        ])),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
