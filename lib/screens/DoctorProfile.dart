import 'dart:math';
import 'package:mero_doctor/screens/dotor_profile.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/models/user.dart';

import 'package:mero_doctor/utils/constants.dart';


class DoctorProfile extends StatefulWidget {
  String? id;
  String? profileUrl;
  String? certificate;
  String? identification;

  DoctorProfile(
      {Key? key,
      this.id,
      this.profileUrl,
      this.certificate,
      this.identification})
      : super(key: key);

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  bool downloading = false;
  String? fullName;
  String? email;
  String? specialization;
  static final Random random = Random();
  bool loading = false;

  DoctorModel _docModel = DoctorModel();
  Dio dio = Dio();
  var progress = "";

  void startDownloading(String value, String name) async {
    loading = false;

    String path = "/sdcard/download/";

    var randid = random.nextInt(10000);
    try {
      await dio.download(
        value,
        path + "$fullName" "$name" + randid.toString() + ".jpg",
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            downloading = true;
            progress =
                ((recivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
          });

          print(progress);
        },
        deleteOnError: true,
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progress = "Download Completed.";
      path = "$name" + randid.toString() + ".jpg";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Download Successful",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.down,
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String firstName;
    String lastName;
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.id)
        .get()
        .then((value) {
      _docModel = DoctorModel.fromMap(value.data());

      setState(() {
        firstName = _docModel.firstName!;
        lastName = _docModel.lastName!;
        email = _docModel.email;
        fullName = firstName + " " + lastName;
        specialization = _docModel.specialization;
        fullName = fullName!.toUpperCase();
        print(fullName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toString();
    int _indexSelected = 3;
    final screen = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const Loading()
          : Scaffold(
              resizeToAvoidBottomInset: false,
              body: downloading
                  ? Center(
                      child: SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Card(
                          color: COLOR_SECONDARY,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const CircularProgressIndicator(),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                'Downloading File: $progress',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: <Widget>[
                              Positioned(
                                  child: Container(
                                width: screen.width,
                                height: screen.height / 3.5,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.elliptical(90, 30),
                                    bottomRight: Radius.elliptical(90, 30),
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                  ),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/bak.png'),
                                      fit: BoxFit.fill),
                                ),
                              )),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 80,
                                    ),
                                    widget.profileUrl == null ||
                                            widget.profileUrl == ""
                                        ? CircleAvatar(
                                            backgroundColor: Colors.grey[800],
                                            backgroundImage: const AssetImage(
                                                "assets/images/doctor_view.png"),
                                            radius: 60,
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.grey[800],
                                            backgroundImage: NetworkImage(
                                                "${widget.profileUrl}"),
                                            radius: 80,
                                          ),
                                    const Divider(
                                      color: Colors.white,
                                    ),
                                    fullName == null || fullName == ""
                                        ? const Text(
                                            "",
                                            style:
                                                TextStyle(color: Colors.black),
                                          )
                                        : Text(
                                            "$fullName",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Color(0xff5d5ba3),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                tooltip: 'Back button',
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileScreenDoc(
                                                id: widget.id!,
                                                profilePicture:
                                                    widget.profileUrl,
                                              )),
                                      (route) => false);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        "Email: ",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                    email == "" || email == null
                                        ? const Text("",
                                            style: TextStyle(
                                              fontSize: 14,
                                            ))
                                        : Text(
                                            "$email",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff5d5ba3)),
                                            ),
                                          ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        "Specialization: ",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                    specialization == "" ||
                                            specialization == null
                                        ? Text(
                                            "",
                                            style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: Color(0xff5d5ba3))),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                2, 10, 0, 0),
                                            child: Text(
                                              "$specialization",
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      color: Color(0xff5d5ba3),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          2, 10, 0, 5),
                                      child: Text(
                                        "Certificate:",
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          6, 11, 0, 5),
                                      child: Text(
                                        "Click on Files to Download",
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.yellow.shade900)),
                                      ),
                                    ),
                                  ],
                                ),
                                widget.certificate != null ||
                                        widget.certificate != ""
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              loading = true;
                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                setState(() {
                                                  startDownloading(
                                                      widget.certificate!,
                                                      'Certificate');
                                                });
                                              });
                                            });
                                          },
                                          child: SizedBox(
                                            height: screen.height / 3,
                                            width: screen.width / 1.2,
                                            child: Image.network(
                                              "${widget.certificate}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                Divider(),
                                widget.identification != null ||
                                        widget.identification != ""
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 5, 0, 0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              loading = true;
                                              Future.delayed(
                                                  const Duration(seconds: 3),
                                                  () {
                                                setState(() {
                                                  startDownloading(
                                                      widget.identification!,
                                                      'Identification');
                                                });
                                              });
                                            });
                                          },
                                          child: SizedBox(
                                            height: screen.height / 3,
                                            width: screen.width / 1.2,
                                            child: Image.network(
                                              "${widget.identification}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
    );
  }
}
