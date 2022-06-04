import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffdaebff),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(
                Icons.menu,
                size: 26,
                color: Colors.black,
              ),
            ),
            Txt(
              'Calender',
              style: TxtStyle()
                ..fontSize(24)
                ..textColor(Colors.black)
                ..alignment.center()
                ..fontWeight(FontWeight.bold),
            ),
            Parent(
              style: ParentStyle()
                ..height(360)
                ..width(screen.width)
                ..borderRadius(all: 12),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Parent(
                  style: ParentStyle()
                    ..height(400)
                    ..width(screen.width)
                    ..background.color(Colors.white)
                    ..borderRadius(topLeft: 32, topRight: 32),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Txt(
                          'Schedule',
                          style: TxtStyle()
                            ..fontSize(24)
                            ..padding(left: 16)
                            ..fontWeight(FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: SizedBox(
                            height: 86,
                            child: ListView(
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Parent(
                              style: ParentStyle()
                                ..height(52)
                                ..elevation(3, color: Colors.black12)
                                ..width(230)
                                ..margin(top: 18)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xffEFB492)),
                              child: Txt(
                                'Book an Appointment',
                                style: TxtStyle()
                                  ..fontSize(16)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..padding(left: 42, top: 10)
                                  ..textColor(Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Txt(
                          'Powered By Mero Health',
                          style: TxtStyle()
                            ..fontSize(12)
                            ..alignment.center()
                            ..margin(top: 18)
                            ..fontFamily('quicksand')
                            ..fontWeight(FontWeight.w500)
                            ..textColor(Colors.black),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}

Widget _getCategoryInfo(String title, String value) {
  return Parent(
    style: ParentStyle()
      ..height(80)
      ..width(92)
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
        ),
      ],
    ),
  );
}
