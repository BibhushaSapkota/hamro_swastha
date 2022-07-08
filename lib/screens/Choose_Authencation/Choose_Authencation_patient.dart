import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/utils/constants.dart';

class ChooseAuth extends StatefulWidget {
  const ChooseAuth({Key? key}) : super(key: key);

  @override
  State<ChooseAuth> createState() => _ChooseAuthState();
}

class _ChooseAuthState extends State<ChooseAuth> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/choose_option");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 85),
              child: Image.asset(
                "assets/images/mero_health_logo.png",
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Center(
              child: InkWell(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: COLOR_WHITE,
                      fontSize: 18,
                    ),
                  ),
                  color: COLOR_SECONDARY,
                  minWidth: screen.width / 2,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "OR",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xff717171),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/register");
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: COLOR_WHITE,
                      fontSize: 18,
                    ),
                  ),
                  color: COLOR_SECONDARY,
                  minWidth: screen.width / 2,
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              "Powered By Mero Health",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
            ),
          ],
        ),
      ),
    ));
  }
}
