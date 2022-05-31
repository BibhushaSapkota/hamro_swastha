import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';
import 'package:mero_doctor/utils/snack_bar.dart';
import 'package:path/path.dart';
import 'loading.dart';
import 'dart:io';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool loading = false;
  int _value = -1;
  // Doctor Post
  String? position = "";

// Specialization Options
  List<String> items = [
    'Select',
    'Cardiologist',
    'Dermatology',
    'Psychiatry',
    'Nephrology',
  ];
  String? specialization = 'Select';

// Local File path.
  String? profileImageURL = "";
  String? identificationImageURL = "";
  String? licenseImageURL = "";

// File name to display in the screen
  String? identificatoinImageURLname = "";
  String? licenseImageURLname = "";

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const LoadingSave()
          : Scaffold(
              body: SizedBox(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Positioned(
                        right: 0,
                        child: Image.asset('assets/images/Vector.png',
                            fit: BoxFit.cover, width: screen.width),
                      ),
                      Txt(
                        'Personal Data',
                        style: TxtStyle()
                          ..fontSize(24)
                          ..padding(left: 16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(const Color(0xff76B5C5)),
                      ),

                      // ---------------- Profile Picture ------------------------------------------------
                      Txt(
                        'Profile Picture',
                        style: TxtStyle()
                          ..fontSize(20)
                          ..fontFamily('quicksand')
                          ..padding(left: 16)
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: profileImageURL == ""
                                      ? Image.asset(
                                          "assets/images/profile.png",
                                          height: 70,
                                          width: 70,
                                        )
                                      : Image.file(
                                          File('$profileImageURL'),
                                        )),
                            ),
                            InkWell(
                              onTap: () async {
                                try {
                                  final image = await ImagePicker().pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (image == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('No File Selected')),
                                    );
                                  }
                                  setState(() {
                                    profileImageURL = image!.path.toString();
                                    print(profileImageURL);
                                  });
                                } catch (e) {
                                  print('Error........');
                                  print(e.toString());
                                }
                              },
                              child: Parent(
                                  style: ParentStyle()
                                    ..height(48)
                                    ..elevation(3, color: Colors.black12)
                                    ..width(170)
                                    ..borderRadius(all: 16)
                                    ..background.color(const Color(0xff76B5C5)),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.upload,
                                        size: 22,
                                        color: Colors.white,
                                      ),
                                      Txt(
                                        'Select Picture',
                                        style: TxtStyle()
                                          ..fontSize(18)
                                          ..margin(left: 8)
                                          ..alignmentContent.centerRight()
                                          ..fontFamily('quicksand')
                                          ..fontWeight(FontWeight.bold)
                                          ..textColor(Colors.white),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),

                      // ------------------------ Doctor Position//Experience ----------------------------------------------------------

                      Txt(
                        'Are you ____________ ?',
                        style: TxtStyle()
                          ..fontSize(18)
                          ..fontFamily('quicksand')
                          ..padding(left: 16)
                          ..textColor(Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                      position = 'Medical Officer';
                                      print(position);
                                    });
                                  },
                                  activeColor: const Color(0xff76B5C5),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Medical Officer'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value as int;
                                      position = 'Medical Manager';
                                      print(position);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Medical Manager'),
                              ],
                            ),
                            // ------------------------ Specialization ----------------------------------------------------------
                            Txt(
                              'Your Specialization ',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.black),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Parent(
                              style: ParentStyle()
                                ..height(42)
                                ..elevation(3, color: Colors.black12)
                                ..width(screen.width)
                                ..margin(left: 16, right: 16)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xff76B5C5)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton<String>(
                                      value: specialization,
                                      items: items
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                        // backgroundColor: Colors.red,
                                                        color: Colors.black,
                                                        fontFamily: 'quicksand',
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )))
                                          .toList(),
                                      onChanged: (item) => setState(() {
                                            specialization = item;
                                            print(specialization);
                                          }),
                                      style: const TextStyle(

                                          // fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // ------------------------ Identification ----------------------------------------------------------
                            Txt(
                              'Upload Your identification ',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(
                                  identificatoinImageURLname == ""
                                      ? 'No File Selected'
                                      : '$identificatoinImageURLname',
                                  style: TxtStyle()
                                    ..fontSize(16)
                                    ..fontFamily('quicksand')
                                    ..fontWeight(FontWeight.bold)
                                    ..textColor(Colors.grey)
                                    ..margin(bottom: 10),
                                ),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      final image =
                                          await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'png',
                                          'jpg',
                                          'pdf'
                                        ],
                                      );
                                      if (image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('No File Selected')),
                                        );
                                      }
                                      setState(() {
                                        identificatoinImageURLname =
                                            image!.files.single.name;
                                        print(identificatoinImageURLname);
                                        identificationImageURL =
                                            image.files.single.path.toString();
                                        print(identificationImageURL);
                                      });
                                    } catch (e) {
                                      print('Error........');
                                      print(e.toString());
                                    }
                                  },
                                  child: Parent(
                                    style: ParentStyle()
                                      ..height(40)
                                      ..elevation(3, color: Colors.black12)
                                      ..width(160)
                                      ..margin(bottom: 12, right: 8)
                                      ..alignment.centerRight(true)
                                      ..borderRadius(all: 16)
                                      ..background
                                          .color(const Color(0xff76B5C5)),
                                    child: Txt(
                                      'Choose a file',
                                      style: TxtStyle()
                                        ..fontSize(16)
                                        ..padding(left: 30, top: 8)
                                        ..fontFamily('quicksand')
                                        ..fontWeight(FontWeight.bold)
                                        ..textColor(Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Txt(
                              'Upload Your Doctor license ',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // ------------------------ License ----------------------------------------------------------
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Txt(
                                  licenseImageURLname == ""
                                      ? 'No File Selected'
                                      : '$licenseImageURLname',
                                  style: TxtStyle()
                                    ..fontSize(16)
                                    ..fontFamily('quicksand')
                                    ..fontWeight(FontWeight.bold)
                                    ..textColor(Colors.grey)
                                    ..margin(bottom: 5),
                                ),
                                InkWell(
                                  onTap: () async {
                                    try {
                                      final image =
                                          await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'png',
                                          'jpg',
                                          'pdf'
                                        ],
                                      );
                                      if (image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('No File Selected')),
                                        );
                                      }
                                      setState(() {
                                        licenseImageURLname =
                                            image!.files.single.name;
                                        print(licenseImageURLname);
                                        licenseImageURL =
                                            image.files.single.path.toString();
                                        print(licenseImageURL);
                                      });
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
                                  child: Parent(
                                    style: ParentStyle()
                                      ..height(40)
                                      ..elevation(3, color: Colors.black12)
                                      ..width(160)
                                      ..margin(right: 8)
                                      ..alignment.centerRight(true)
                                      ..borderRadius(all: 16)
                                      ..background
                                          .color(const Color(0xff76B5C5)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Txt(
                                            'Choose a file',
                                            style: TxtStyle()
                                              ..fontSize(16)
                                              ..padding(
                                                left: 26,
                                              )
                                              ..fontFamily('quicksand')
                                              ..fontWeight(FontWeight.bold)
                                              ..textColor(Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

// ------------------------------ Submit -----------------------------------
                            Center(
                              child: Parent(
                                style: ParentStyle()
                                  ..height(44)
                                  ..elevation(3, color: Colors.black12)
                                  ..width(136)
                                  ..margin(top: 8)
                                  ..borderRadius(all: 16)
                                  ..background.color(const Color(0xffEFB492)),
                                child: InkWell(
                                  onTap: () {
                                    // If Identification File is chosen.
                                    if (identificationImageURL != "") {
                                      // If License File is  chosen
                                      if (licenseImageURL != "") {
                                        // If specialization option is ticked.
                                        if (specialization != "Select") {
                                          // If Doctor post is ticked.
                                          if (position != "") {
                                            setState(() {
                                              loading = true;
                                            });
                                            postDetails().whenComplete(() {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const DoctorDashboard()));
                                            });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackMessage
                                                    .snackBarPositionFail);

                                            return;
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackMessage
                                                  .snackBarSpecializationFail);

                                          return;
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackMessage
                                                .snackBarLicenseFail);

                                        return;
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackMessage
                                              .snackBarIdentificationFail);
                                      return;
                                    }
                                  },
                                  child: Txt(
                                    'Submit',
                                    style: TxtStyle()
                                      ..fontSize(16)
                                      ..alignmentContent.center(true)
                                      ..fontFamily('quicksand')
                                      ..fontWeight(FontWeight.bold)
                                      ..textColor(Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future postDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    // DownloadURL path
    String? profileImageDownloadURL;
    String? identificationImageDownloadURL;
    String? licenseImageDownloadURL;

    // if (identificationImageURL != "") {
    //   if (licenseImageURL != "") {

    //   }
    // }

    if (profileImageURL != "") {
      // Creating a file with user uid 1 and adding profile.
      Reference ref1 = firebaseStorage.ref('doctorfiles/${user?.uid}1');

      await ref1.putFile(File(profileImageURL!)).catchError((e) {
        print(e.toString());
      });
      // Getting Download link or path from networ;
      ref1.getDownloadURL().then((value) {
        setState(() {
          profileImageDownloadURL = value.toString();
          print(profileImageDownloadURL);
        });
      });
    }

    // Creating a file with user uid 2 and adding identification file.
    Reference ref2 = firebaseStorage.ref('doctorfiles/${user?.uid}2');
    // Creating a file with user uid 3 and adding license file.
    Reference ref3 = firebaseStorage.ref('doctorfiles/${user?.uid}3');

    await ref2.putFile(File(identificationImageURL!)).catchError((e) {
      print(e.toString());
    });
    await ref3.putFile(File(licenseImageURL!)).catchError((e) {
      print(e.toString());
    });

    ref2.getDownloadURL().then((value) {
      setState(() {
        identificationImageDownloadURL = value.toString();
        print(identificationImageDownloadURL);
      });
    });
    ref3.getDownloadURL().then((value) {
      setState(() {
        licenseImageDownloadURL = value.toString();
        print(licenseImageDownloadURL);
      });
      FirebaseFirestore.instance.collection('doctors').doc(user?.uid).update({
        'specialization': specialization,
        'position': position,
        'profileImageDownloadURL': profileImageDownloadURL,
        'identificationImageDownloadURL': identificationImageDownloadURL,
        'licenseImageDownloadURL': licenseImageDownloadURL,
      });
    });
  }
}
