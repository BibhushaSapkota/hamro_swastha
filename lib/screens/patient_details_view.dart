import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/utils/constants.dart';

class PatientProfileView extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? email;
  String? profileUrl;
  String? dateOfBirth;
  PatientProfileView(
      {Key? key,
      this.firstName,
      this.lastName,
      this.email,
      this.profileUrl,
      this.dateOfBirth})
      : super(key: key);

  @override
  State<PatientProfileView> createState() => _PatientProfileViewState();
}

class _PatientProfileViewState extends State<PatientProfileView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: COLOR_SECONDARY,
            centerTitle: true,
            title: Text("Patient Card"),
            leading: BackButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => DoctorDashboardScreen()),
                    (route) => false);
              },
              color: Colors.white,
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                child: Column(
                  children: [
                    widget.profileUrl != null || widget.profileUrl != ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(
                              widget.profileUrl!,
                              scale: 1.0,
                              height: 120,
                              width: 120,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.asset(
                              "assets/images/profile.jpg",
                              scale: 1.0,
                              height: 120,
                              width: 120,
                            ),
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(children: [
                      Text(
                        "Full Name: ",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${widget.firstName} ${widget.lastName}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Text("Email:",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${widget.email}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: [
                      Text("Date of Birth:",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${widget.dateOfBirth}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
