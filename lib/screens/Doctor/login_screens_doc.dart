import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/auth_doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/GoogleLogin/google_login.dart';
// import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:mero_doctor/utils/snack_bar.dart';
import 'package:provider/provider.dart';

class LoginPageDoc extends StatefulWidget {
  const LoginPageDoc({Key? key}) : super(key: key);

  @override
  State<LoginPageDoc> createState() => _LoginPageDocState();
}

class _LoginPageDocState extends State<LoginPageDoc> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  void signIn(String email, String password) async {
    String lowerEmail = email.toLowerCase();

    if (_formKey.currentState!.validate()) {
      setState(() {
        // Future<String> output = obj.isPatient(lowerEmail);

        loading = true;
      });
      // String? isPatient;
      dynamic result = await _auth
          .signInWithEmailAndPassword(email: lowerEmail, password: password)
          .then((uid) => {
                // isPatient = obj.isPatient(lowerEmail),
                // // ignore: unrelated_type_equality_checks
                // if (obj.isPatient(lowerEmail) == 'true')
                //   {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackMessage.successSnackBar("Login Successful.")),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoadingScreenDoc()))
                // }
                // else
                //   {
                //     const SnackBar(
                //       content: Text(
                //         "Login Failed",
                //         style: TextStyle(
                //           fontWeight: FontWeight.w400,
                //           color: Colors.white,
                //         ),
                //       ),
                //       backgroundColor: Colors.redAccent,
                //     )
                //   }
              })
          .catchError((e) {
        setState(() {
          loading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Invalid Email or Password",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent,
        ));
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
    final TapGestureRecognizer _gesturesRecongnizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.of(context).pushNamed('/register_doctor');
      };
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
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, "/authDoc");
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
                                            } else if (!RegExp(
                                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                .hasMatch(value)) {
                                              return "Please! Enter a valid Email";
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
                                                          ..onTap = () => {})
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
                                          height: 5,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            final provider = Provider.of<
                                                    GoogleLogInProvider>(
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          "/register_doctor");
                                                },
                                                child: RichText(
                                                    text: TextSpan(
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16),
                                                        children: [
                                                      const TextSpan(
                                                          text:
                                                              "Don't have account? "),
                                                      TextSpan(
                                                          text: "Sign Up",
                                                          style: const TextStyle(
                                                              color:
                                                                  COLOR_SECONDARY,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          recognizer:
                                                              _gesturesRecongnizer)
                                                    ])),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screen.height / 11.5,
                                  ),
                                  Image.asset(
                                      "assets/images/ic_login_bottom.png",
                                      width: screen.width,
                                      fit: BoxFit.fill),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ));
  }

  Future postDetails(data) async {
    DoctorModel doctorModel = DoctorModel();
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(data.uid)
        .get()
        .then((value) {
      print('Value Exists or not???.......');
      print(value.exists);

      if (value.exists) {
        print('Value Exists');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoadingScreenDoc()));
      } else {
        doctorModel.docid = data.uid.toString();
        doctorModel.firstName = data.displayName.toString();
        doctorModel.email = data.email.toString();
        doctorModel.profileImageDownloadURL = data.photoURL.toString();
        doctorModel.isFormCompleted = false;
        doctorModel.isDoctor = true;
        doctorModel.isGoogleUser = true;
        doctorModel.isNormalUser = false;
        FirebaseFirestore.instance
            .collection('doctors')
            .doc(data.uid)
            .set(doctorModel.toMap())
            .whenComplete(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoadingScreenDoc()));
        });
      }
    });
  }
}
