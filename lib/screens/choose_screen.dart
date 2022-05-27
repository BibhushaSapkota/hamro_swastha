import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  State<ChooseScreen> createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 85),
                child: Image.asset(
                  "assets/images/mero_health_logo.png",
                  height: 200,
                  width: 250,
                ),
              ),
              Text(
                "Who are you?",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: MaterialButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "/authDoc"),
                      child: Image.asset(
                        "assets/images/doctor.png",
                        height: 100,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(30)),
                    ),
                  ),
                  Text(
                    "OR",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                  ),
                  InkWell(
                    child: MaterialButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "/auth"),
                      child: Image.asset(
                        "assets/images/patient.png",
                        height: 100,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(30)),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Doctor",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                    Text(
                      "",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                    Text(
                      "Patient",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 160,
              ),
              Image.asset(
                "assets/images/wave.png",
                fit: BoxFit.fill,
                width: screen.width,
              )
            ],
          ),
        ),
      ),
    );
  }
}
