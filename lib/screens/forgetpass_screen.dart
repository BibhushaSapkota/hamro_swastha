import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/screens/otp_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EnterEmailPage extends StatefulWidget {
  EnterEmailPage({Key? key}) : super(key: key);

  @override
  State<EnterEmailPage> createState() => _EnterEmailPageState();
}

class _EnterEmailPageState extends State<EnterEmailPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  String? email;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_SECONDARY,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text(
          "Reset Password",
          style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 18)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Text(
                "Email Address",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: COLOR_GREY,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email should not be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  emailController.text = value!;
                },
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  fillColor: Colors.black12,
                  hintText: "Enter your email address",
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      fontSize: 16, height: 0.8, color: Colors.black54),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  email = emailController.text.toLowerCase();
                  print(email);
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => EnterOtpPage(email: email)),
                        (route) => false);
                  }
                },
                color: COLOR_SECONDARY,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                minWidth: screen.width / 2,
                height: 50,
                child: const Text(
                  "SEND OTP",
                  style: TextStyle(color: COLOR_WHITE, fontSize: 18),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
