import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'
    show
        BorderRadius,
        BoxFit,
        BuildContext,
        Column,
        Container,
        EdgeInsets,
        FontWeight,
        FormState,
        GlobalKey,
        Image,
        MediaQuery,
        Padding,
        RoundedRectangleBorder,
        Row,
        Size,
        SizedBox,
        Stack,
        State,
        StatefulWidget,
        Text,
        Widget;

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? _selectedDate;
  String? gender;
  final formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/ic_reportPatient2.png",
                  width: screen.width / 2,
                  height: screen.height / 6,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Image.asset("assets/images/ic_Reportpat.png",
                  width: screen.width,
                  height: screen.height / 8,
                  fit: BoxFit.fill),
            ),
            SizedBox(
              height: 30,
            ),
            Txt(
              "Personal Data",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.blue)
                ..fontSize(16)
                ..margin(top: 130)
                ..padding(left: 20),
            ),
            Txt(
              "Personal Data",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.black)
                ..fontSize(10)
                ..margin(top: 165)
                ..padding(left: 20),
            ),
            Row(
              children: [
                Txt(
                  "File Name.img",
                  style: TxtStyle()
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.grey)
                    ..fontSize(10)
                    ..margin(top: 177)
                    ..padding(left: 44),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(88, 180, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(150, 40), //////// HERE
                    ),
                    onPressed: () {},
                    child: Text('Upload Photo'),
                  ),
                )
              ],
            ),
            Txt(
              "Birthday",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.black)
                ..fontSize(10)
                ..margin(top: 225)
                ..padding(left: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 250, 10, 0),
              child: Container(
                height: 60,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime(2022, 1, 1),
                  onDateTimeChanged: (DateTime newDateTime) {
                    // Do something
                  },
                ),
              ),
            ),
            Txt(
              "Gender",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.black)
                ..fontSize(10)
                ..margin(top: 320)
                ..padding(left: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 340, 0, 0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.values.first,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: 'null',
                                onChanged: (index) {}),
                            Text(
                              'Male',
                              style: TextStyle(fontSize: 11),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: 'null',
                                onChanged: (index) {}),
                            Text('Female', style: TextStyle(fontSize: 11))
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: 'null',
                                onChanged: (index) {}),
                            Text('Other', style: TextStyle(fontSize: 11))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Txt(
              "Contact No.",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.black)
                ..fontSize(10)
                ..margin(top: 389)
                ..padding(left: 20),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 401, 40, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '+977   Phone Number',
                ),
              ),
            ),
            Txt(
              "Old medical report",
              style: TxtStyle()
                ..fontWeight(FontWeight.bold)
                ..textColor(Colors.black)
                ..fontSize(10)
                ..margin(top: 465)
                ..padding(left: 20),
            ),
            Row(
              children: [
                Txt(
                  "File Name.img",
                  style: TxtStyle()
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.grey)
                    ..fontSize(10)
                    ..margin(top: 485)
                    ..padding(left: 44),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(88, 490, 0, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      shadowColor: Colors.greenAccent,
                      elevation: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(150, 40),
                    ),
                    onPressed: () {},
                    child: Text('Upload Photo'),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(115, 565, 40, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  elevation: 200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  minimumSize: Size(150, 50), //////// HERE
                ),
                onPressed: () {},
                child: Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
