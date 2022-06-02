import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PatientUploadScreen extends StatefulWidget {
  const PatientUploadScreen({Key? key}) : super(key: key);

  @override
  State<PatientUploadScreen> createState() => _PatientUploadScreenState();
}

class _PatientUploadScreenState extends State<PatientUploadScreen> {
  DateTime _dateTime = DateTime.now();
  String? gender;
  final TextEditingController phoneController = TextEditingController();
  String initialCountry = 'NP';
  PhoneNumber number = PhoneNumber(isoCode: 'NP');

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                      InkWell(
                        child: MaterialButton(
                          onPressed: () {},
                          child: Parent(
                              style: ParentStyle()
                                ..height(44)
                                ..elevation(3, color: Colors.black12)
                                ..width(170)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xff76B5C5)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_upward,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Upload Picture',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
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
                SizedBox(
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
                      });
                    },
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
                                  gender = value.toString();
                                });
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Others'),
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
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
                        textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    )),
                    textFieldController: phoneController,
                    formatInput: false,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true, decimal: true),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("File Name.pdf"),
                      Parent(
                        style: ParentStyle()
                          ..height(40)
                          ..elevation(3, color: Colors.black12)
                          ..width(160)
                          ..alignment.centerRight()
                          ..margin(right: 14)
                          ..borderRadius(all: 16)
                          ..background.color(const Color(0xff76B5C5)),
                        child: Txt(
                          'Upload file',
                          style: TxtStyle()
                            ..fontSize(16)
                            ..padding(left: 30, top: 10)
                            ..fontFamily('quicksand')
                            ..fontWeight(FontWeight.bold)
                            ..textColor(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
