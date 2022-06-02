import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientUploadScreen extends StatefulWidget {
  const PatientUploadScreen({Key? key}) : super(key: key);

  @override
  State<PatientUploadScreen> createState() => _PatientUploadScreenState();
}

class _PatientUploadScreenState extends State<PatientUploadScreen> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
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
                    Parent(
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
                              Icon(
                                Icons.arrow_upward,
                                size: 22,
                                color: Colors.white,
                              ),
                              Txt(
                                'Upload Picture',
                                style: TxtStyle()
                                  ..fontSize(18)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..textColor(Colors.white),
                              ),
                            ],
                          ),
                        )),
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
              SizedBox(
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
                            value: 1,
                            groupValue: 1,
                            onChanged: (value) {},
                            activeColor: const Color(0xff76B5C5),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: 2,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Female'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: 2,
                            onChanged: (value) {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Others'),
                        ],
                      )
                    ]),
              ),
              SizedBox(
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
              Txt(
                'Upload your old file',
                style: TxtStyle()
                  ..fontSize(18)
                  ..padding(left: 16)
                  ..fontFamily('quicksand')
                  ..fontWeight(FontWeight.bold)
                  ..textColor(Colors.black),
              ),
              SizedBox(
                height: 16,
              ),
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
    );
  }
}
