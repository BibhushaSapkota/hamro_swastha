import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mero_doctor/models/auth_patient.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/GoogleLogin/google_login.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:mero_doctor/utils/snack_bar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackMessage.successSnackBar("Login Successful.")),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoaderScreen())),
                Fluttertoast.showToast(msg: "Login Successful"),
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => DashboardScreen(id: '')))
              })
          .catchError((e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackMessage.errorSnackBar("Invalid Email or Password"));
      });

      if (result != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
        child: loading
            ? const Loading()
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
                          child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/auth");
                        },
                      )),
                      Positioned(
                        top: screen.height / 3 - 80,
                        height: screen.height - screen.height / 3 + 80,
                        width: screen.width,
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: COLOR_SECONDARY,
                                            fontSize: 30),
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Email should not be empty";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          emailController.text = value!;
                                        },
                                        decoration: const InputDecoration(
                                          fillColor: Colors.black12,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                        style: const TextStyle(
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
                                                color: COLOR_GREY,
                                                fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Password should not be empty";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          passwordController.text = value!;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          fillColor: Colors.black12,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                        ),
                                        style: const TextStyle(
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
                                            style: const TextStyle(
                                                color: COLOR_BLACK,
                                                fontSize: 16),
                                            children: [
                                              TextSpan(
                                                  text: "Click Here",
                                                  style: const TextStyle(
                                                      color: COLOR_SECONDARY),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap =
                                                            () => {
                                                                  Navigator.pushReplacementNamed(
                                                                      context,
                                                                      "/forgetpass")
                                                                })
                                            ]),
                                      ),
                                      const SizedBox(
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
                                                color: COLOR_WHITE,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          final provider =
                                              Provider.of<GoogleLogInProvider>(
                                                  context,
                                                  listen: false);
                                          provider.googleLogout();
                                        },
                                        child: const Text('Logout'),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          height: 50.0,
                                          width: 50.0,
                                          child: InkWell(
                                            onTap: () {
                                              final provider = Provider.of<
                                                      GoogleLogInProvider>(
                                                  context,
                                                  listen: false);
                                              provider
                                                  .googleLogin()
                                                  .then((data) {
                                                postDetails(data);
                                              });
                                            },
                                            child: Image.asset(
                                                "assets/images/google.png"),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RichText(
                                              text: const TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            "Don't have account? ")
                                                  ]),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    "/register_patient");
                                              },
                                              child: RichText(
                                                  text: const TextSpan(
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                      children: [
                                                    TextSpan(
                                                      text: "Sign Up",
                                                      style: TextStyle(
                                                          color:
                                                              COLOR_SECONDARY,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ])),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: screen.height / 13.5,
                                // ),
                                // Image.asset("assets/images/ic_login_bottom.png",
                                //     width: screen.width, fit: BoxFit.fill),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Future postDetails(data) async {
    UserModel userModel = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(data.uid)
        .get()
        .then((value) {
      print('Value Exists or not???.......');
      print(value.exists);

      if (value.exists) {
        print('Value Exists');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoaderScreen()));
      } else {
        userModel.firstName = data.displayName.toString();
        userModel.email = data.email.toString();
        userModel.profilePicture = data.photoURL.toString();
        userModel.isFormCompleted = false;
        userModel.isPatient = true;
        userModel.isGoogleUser = true;
        userModel.isNormalUser = false;
        FirebaseFirestore.instance
            .collection('users')
            .doc(data.uid)
            .set(userModel.toMap())
            .whenComplete(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoaderScreen()));
        });
      }
    });
  }
}
