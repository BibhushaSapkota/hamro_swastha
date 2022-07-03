import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/screens/doctor_category.dart';

import '../models/category.dart';

class DoctorCategoryWidget extends StatelessWidget {
  final DiseasesCategory category;
  String? profileUrl;
  DoctorCategoryWidget({required this.category, this.profileUrl}) : super();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DoctorCategoryScreen(
                  category: category, profileUrl: profileUrl)),
        );
      },
      child: Container(
        child: Column(
          children: [
            Parent(
                style: ParentStyle()
                  ..height(118)
                  ..boxShadow(
                      color: const Color(0xffdddef2),
                      blur: 10,
                      offset: const Offset(0, 6))
                  ..borderRadius(all: 12)
                  ..margin(right: 14)
                  ..width(110)
                  ..background.color(Colors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Image.asset(
                        category.image,
                        scale: 4,
                      ),
                    ),
                    Txt(
                      category.name,
                      style: TxtStyle()
                        ..fontFamily('quicksand')
                        ..textAlign.center()
                        ..fontSize(10)
                        ..fontWeight(FontWeight.bold)
                        ..margin(vertical: 8)
                        ..textColor(const Color(0xff535282)),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
