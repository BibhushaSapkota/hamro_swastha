import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/screens/loading.dart';
import 'package:mero_doctor/utils/snack_bar.dart';

class PatientUploadScreen extends StatefulWidget {
  const PatientUploadScreen({Key? key}) : super(key: key);

  @override
  State<PatientUploadScreen> createState() => _PatientUploadScreenState();
}

class _PatientUploadScreenState extends State<PatientUploadScreen> {
  String? id;
  bool loading = false;
  DateTime _dateTime = DateTime.utc(2022, 03, 6);
  String? date;
  String? gender;
  final TextEditingController phoneController = TextEditingController();
  String initialCountry = 'NP';
  PhoneNumber number = PhoneNumber(isoCode: 'NP');
  String? profileImage = '';
  String? oldReportImage = '';
  String? oldReportImageUrlName = '';

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const LoadingSave()
          : Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/Vector.png',
                        fit: BoxFit.fill,
                        width: screen.width,
                        height: screen.height / 4,
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
                                child: profileImage == ""
                                    ? Image.asset(
                                        "assets/images/profile.png",
                                        height: 70,
                                        width: 70,
                                      )
                                    : Image.file(
                                        File('$profileImage'),
                                      ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
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
                                    profileImage = image!.path.toString();
                                    print(profileImage);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.upload,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      Txt(
                                        'Upload Picture',
                                        style: TxtStyle()
                                          ..fontSize(16)
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
                      Txt(
                        'Birthday',
                        style: TxtStyle()
                          ..fontSize(18)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..padding(left: 16)
                          ..textColor(Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: CupertinoDatePicker(
                          initialDateTime: _dateTime,
                          backgroundColor: Colors.white,
                          onDateTimeChanged: (dateTime) {
                            print(dateTime);
                            setState(() {
                              _dateTime = dateTime;
                              date = _dateTime.toString();
                            });
                          },
                          dateOrder: DatePickerDateOrder.dmy,
                        ),
                      ),
                      Txt(
                        'Gender',
                        style: TxtStyle()
                          ..fontSize(18)
                          ..padding(left: 16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: 'male',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value.toString());
                                        gender = value.toString();
                                      });
                                    },
                                    activeColor: const Color(0xff76B5C5),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text('Male'),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value.toString());
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: 'others',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        print(value.toString());
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text('Others'),
                                ],
                              )
                            ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Txt(
                        'Contact no',
                        style: TxtStyle()
                          ..fontSize(18)
                          ..padding(left: 16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber value) {
                            print(value.phoneNumber);
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DROPDOWN,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          initialValue: number,
                          textStyle: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          )),
                          textFieldController: phoneController,
                          formatInput: false,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onSaved: (value) {
                            phoneController.text = value.phoneNumber.toString();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Txt(
                        'Upload your old file',
                        style: TxtStyle()
                          ..fontSize(18)
                          ..padding(left: 16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Txt(
                              oldReportImage == ""
                                  ? 'No File Selected'
                                  : '$oldReportImage',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.grey)
                                ..margin(bottom: 10),
                            ),
                            Expanded(
                              child: MaterialButton(
                                onPressed: () async {
                                  try {
                                    final oldFile =
                                        await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: ['png', 'jpg', 'pdf'],
                                    );
                                    if (oldFile == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('No File Selected')),
                                      );
                                    }
                                    setState(() {
                                      oldReportImage =
                                          oldFile!.files.single.name;
                                      print(oldReportImage);
                                      oldReportImageUrlName =
                                          oldFile.files.single.path.toString();
                                      print(oldReportImageUrlName);
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.upload,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      Txt(
                                        'Upload File',
                                        style: TxtStyle()
                                          ..fontSize(16)
                                          ..margin(left: 8)
                                          ..alignmentContent.centerRight()
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: MaterialButton(
                          onPressed: () {
                            if (profileImage != "") {
                              if (date!.isNotEmpty) {
                                if (gender != "") {
                                  if (phoneController.text.isNotEmpty) {
                                    if (oldReportImageUrlName != "") {
                                      setState(() {
                                        loading = true;
                                      });
                                      postDetails().whenComplete(() {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardScreen(id: '$id'),
                                        ));
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackMessage.snackBarDateFail);
                                      return;
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackMessage.snackBarPhoneFail);
                                    return;
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackMessage.snackBarGenderFail);
                                  return;
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackMessage.snackBarDateFail);
                                return;
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackMessage.snackBarProfileFail);
                              return;
                            }
                          },
                          child: Parent(
                            style: ParentStyle()
                              ..height(44)
                              ..elevation(3, color: Colors.black12)
                              ..width(142)
                              ..margin(top: 8)
                              ..borderRadius(all: 16)
                              ..background.color(const Color(0xffEFB492)),
                            child: Txt(
                              'Submit',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..padding(left: 42, top: 10)
                                ..textColor(Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future postDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    id = user?.uid;
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    // DownloadURL path
    String? profileImageDownloadUrl;
    String? oldReportDownloadURL;

    // if (identificationImageURL != "") {
    //   if (licenseImageURL != "") {

    //   }
    // }

    if (profileImage != "") {
      // Creating a file with user uid 1 and adding profile.
      Reference ref1 = firebaseStorage.ref('patientfiles/${user?.uid}_profile');

      await ref1.putFile(File(profileImage!)).catchError((e) {
        print(e.toString());
      });
      // Getting Download link or path from networ;
      ref1.getDownloadURL().then((value) {
        setState(() {
          profileImageDownloadUrl = value.toString();
          print(profileImageDownloadUrl);
        });
      });
    }

    // Creating a file with user uid 2 and adding identification file.
    Reference ref2 = firebaseStorage.ref('patientfiles/${user?.uid}_report');

    await ref2.putFile(File(oldReportImageUrlName!)).catchError((e) {
      print(e.toString());
    });

    ref2.getDownloadURL().then((value) {
      if (mounted) {
        setState(() {
          oldReportDownloadURL = value.toString();
          print(oldReportDownloadURL);
        });
      }
    });
    FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
      'profilePicture': profileImageDownloadUrl,
      'gender': gender,
      'dateOfBirth': date,
      'oldReportFile': oldReportDownloadURL,
      'contact': phoneController.text,
    });
  }
}
