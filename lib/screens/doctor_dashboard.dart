import 'package:division/division.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/category.dart';

import '../models/data.dart';
import '../widgets/doctor_dashboard_widgets.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          itemExtent: screen.height,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Txt(
                  'Doctors For Life',
                  style: TxtStyle()
                    ..fontSize(22)
                    ..padding(horizontal: 24, vertical: 10)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                Parent(
                  style: ParentStyle()
                    ..borderRadius(all: 15)
                    ..background.image(
                        path: 'assets/images/ic_doctor12.png',
                        fit: BoxFit.cover)
                    ..width(screen.width)
                    ..height(200)
                    ..margin(
                      bottom: 10,
                    )
                    ..boxShadow(
                        color: const Color(0xffe6e3fe),
                        blur: 10,
                        offset: const Offset(0, 5)),
                ),
                Center(
                  child: Txt(
                    ' Save Your Life',
                    style: TxtStyle()
                      ..fontSize(20)
                      ..fontWeight(FontWeight.bold)
                      ..textColor(Colors.black)
                      ..fontFamily('quicksand'),
                  ),
                ),
                Txt(
                  ' Schedules',
                  style: TxtStyle()
                    ..fontSize(22)
                    ..padding(horizontal: 24, vertical: 10)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                SizedBox(
                  height: 80,
                  child: ListView(
                    padding: const EdgeInsets.only(left: 24, bottom: 10),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      _getCategoryInfo("Sun", "01"),
                      _getCategoryInfo("Mon", "09"),
                      _getCategoryInfo("Tues", "07"),
                      _getCategoryInfo("Wed", "03"),
                      _getCategoryInfo("Thur", "12"),
                      _getCategoryInfo("Frid", "7"),
                    ],
                  ),
                ),
                Txt(
                  ' Appointments',
                  style: TxtStyle()
                    ..fontSize(22)
                    ..margin(horizontal: 24, vertical: 10)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children:
                    DoctorDashBoard.map((e) => DoctorDashBoardWidget(e))
                        .toList(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getCategoryInfo(String title, String value) {
  return Parent(
    style: ParentStyle()
      ..height(80)
      ..width(80)
      ..elevation(3, color: Colors.grey.withOpacity(0.5))
      ..margin(right: 10)
      ..borderRadius(all: 10)
      ..background.color(Colors.grey.shade100),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Txt(
          title,
          style: TxtStyle()
            ..fontSize(12)
            ..fontWeight(FontWeight.bold)
            ..textColor(const Color(0xff76B5C5)),
        ),
        Txt(
          value,
          style: TxtStyle()
            ..margin(top: 10)
            ..fontSize(12)
            ..textColor(Colors.black),
        )
      ],
    ),
  );
}
