import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/Doctor/login_screens_doc.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:mero_doctor/utils/snack_bar.dart';

class RegisterScreenDoc extends StatefulWidget {
  @override
  State<RegisterScreenDoc> createState() => _RegisterScreenDocState();
}

class _RegisterScreenDocState extends State<RegisterScreenDoc> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String Success_message = '';

  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
        child: loading
            ? const Loading()
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  body: SizedBox(
                    height: screen.height,
                    width: screen.width,
                    child: Stack(
                      children: [
                        // Positioned(
                        //   bottom: 0,
                        //   child:
                        // ),

                        Positioned(
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/ic_login_bg.png",
                                    width: screen.width,
                                    height: screen.height / 3,
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                                color: COLOR_SECONDARY,
                                                fontSize: 25),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "First Name",
                                            style: TextStyle(
                                                color: COLOR_GREY,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "First Name should not be empty";
                                              } else if (value.startsWith(
                                                  RegExp(r'[0-9]'))) {
                                                return "First Letter should not be integer.";
                                              }
                                              return null;
                                            },
                                            controller:
                                                firstNameEditingController,
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.account_circle),
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
                                          const Text(
                                            "Last Name",
                                            style: TextStyle(
                                                color: COLOR_GREY,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Last Name should not be empty";
                                              } else if (value.startsWith(
                                                  RegExp(r'[0-9]'))) {
                                                return "First Letter should not be integer.";
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            controller:
                                                lastNameEditingController,
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.account_circle),
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
                                            "E-mail",
                                            style: themeData.textTheme.bodyText2
                                                ?.copyWith(
                                                    color: COLOR_GREY,
                                                    fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
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
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: emailEditingController,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.mail),
                                              fillColor: Colors.black12,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                height: 0.8,
                                                color: Colors.black54),
                                            keyboardType:
                                                TextInputType.emailAddress,
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
                                            autofocus: false,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Password should not be empty";
                                              } else if (value.length < 6) {
                                                return "Password must be 6 character or more";
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            controller:
                                                passwordEditingController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.key),
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
                                            "Confirm Password",
                                            style: themeData.textTheme.bodyText2
                                                ?.copyWith(
                                                    color: COLOR_GREY,
                                                    fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          TextFormField(
                                            autofocus: false,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Password should not be empty";
                                              } else if (value.length < 6 &&
                                                  passwordEditingController
                                                          .text !=
                                                      value) {
                                                return "Password don't match";
                                              }
                                              return null;
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            controller:
                                                confirmPasswordEditingController,
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.key),
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
                                          Center(
                                            child: MaterialButton(
                                              onPressed: () {
                                                signUp(
                                                    emailEditingController.text
                                                        .toLowerCase(),
                                                    passwordEditingController
                                                        .text);
                                              },
                                              color: COLOR_SECONDARY,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                              ),
                                              minWidth: screen.width / 2,
                                              height: 50,
                                              child: const Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                    color: COLOR_WHITE,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: RichText(
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                    children: [
                                                  const TextSpan(
                                                      text:
                                                          "Already have account? "),
                                                  TextSpan(
                                                      text: "Login",
                                                      style: const TextStyle(
                                                          color:
                                                              COLOR_SECONDARY,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () => Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                "/login")),
                                                ])),
                                          ),
                                          const SizedBox(height: 20.0),
                                          Text(
                                            Success_message,
                                            style: TextStyle(
                                                color: Colors.green[20]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                      "assets/images/ic_login_bottom.png",
                                      width: screen.width,
                                      fit: BoxFit.fill),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, "/authDoc");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      dynamic result = await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsFireStore()})
          .catchError((e) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackMessage.snackBarAccountFail);
        SnackBar(
          content: Text(
            "${e.message}",
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.redAccent,
        );
      });

      if (result != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  postDetailsFireStore() async {
    //Calling our Fire Store
    //Calling our User Model
    //Sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    DoctorModel docModel = DoctorModel();

    docModel.email = user!.email;
    docModel.docid = user.uid;
    docModel.firstName = firstNameEditingController.text;
    docModel.lastName = lastNameEditingController.text;
    docModel.password = passwordEditingController.text;
    docModel.isDoctor = true;
    docModel.isFormCompleted = false;
    docModel.description = "";
    docModel.identificationImageDownloadURL = "";
    docModel.licenseImageDownloadURL = "";
    docModel.profileImageDownloadURL = "";
    docModel.specialization = "";

    await firebaseFirestore
        .collection("doctors")
        .doc(user.uid)
        .set(docModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
        SnackMessage.successSnackBar("Account Created Successful."));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPageDoc()),
        (route) => false);
  }
}
