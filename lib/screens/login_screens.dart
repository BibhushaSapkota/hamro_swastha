import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/screens/loading.dart';


class EmailFieldValidator {
  static String? validate(String value){
    if (value.isEmpty) {
      return "Email should not be empty";
        } 
    return null;
  }

  }

class PasswordFieldValidator {
  static String? validate(String value){
    if (value!.isEmpty) {
       return "Password should not be empty";
        } 
       return null;
      }
  }


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TapGestureRecognizer _gesturesRecongnizer = TapGestureRecognizer()
    ..onTap = () {
      debugPrint("Hello World");
    };
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  bool loading = false;

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => DashboardScreen()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });

      if (result != null) {
        loading = false;
      }
    }
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
        child: loading
            ? Loading()
            : Scaffold(
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
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: COLOR_SECONDARY, fontSize: 30),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "E-mail",
                                      style: TextStyle(
                                          color: COLOR_GREY, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      validator: (value) => EmailFieldValidator.validate(value!),
                                      onSaved: (value) {
                                        emailController.text = value!;
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Colors.black12,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 0.8,
                                          color: Colors.black54),
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Password",
                                      style: themeData.textTheme.bodyText2
                                          ?.copyWith(
                                              color: COLOR_GREY, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: (value) => PasswordFieldValidator.validate(value!),
                                      onSaved: (value) {
                                        passwordController.text = value!;
                                      },
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        fillColor: Colors.black12,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      style: TextStyle(
                                          fontSize: 16,
                                          height: 0.8,
                                          color: Colors.black54),
                                      keyboardType: TextInputType.text,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: "Forgot your password? ",
                                          style: TextStyle(
                                              color: COLOR_BLACK, fontSize: 16),
                                          children: [
                                            TextSpan(
                                                text: "Click Here",
                                                style: TextStyle(
                                                    color: COLOR_SECONDARY),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () => {})
                                          ]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          signIn(emailController.text,
                                              passwordController.text);
                                        },
                                        color: COLOR_SECONDARY,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        minWidth: screen.width / 2,
                                        height: 50,
                                        child: const Text(
                                          "Sign In",
                                          style: TextStyle(
                                              color: COLOR_WHITE, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                              context, "/login");
                                        },
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                children: [
                                              TextSpan(
                                                  text: "Don't have account? "),
                                              TextSpan(
                                                  text: "Login",
                                                  style: TextStyle(
                                                      color: COLOR_SECONDARY,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  recognizer:
                                                      _gesturesRecongnizer)
                                            ])),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ));
  }
}
