import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../models/category.dart';

class TopDoctorWidget extends StatelessWidget {
  final TopDoctorCategory category;

  const TopDoctorWidget(this.category) : super();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Parent(
        style: ParentStyle()
          ..height(84)
          ..borderRadius(all: 10)
          ..margin(top: 10)
          ..width(screen.width)
          ..elevation(3, color: Colors.grey.shade200)
          ..background.color(category.bgColor),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Parent(
                    style: ParentStyle()
                      ..width(60)
                      ..height(60)
                      ..borderRadius(all: 60)
                      ..elevation(4, color: Colors.grey.shade300)
                      ..background.color(category.bgColor2)),
                Image.asset(
                  category.image,
                  height: 60,
                  width: 60,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12, left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Txt(
                      category.name,
                      style: TxtStyle()
                        ..fontSize(16)
                        ..textColor(const Color(0xff7f819b))
                        ..fontWeight(FontWeight.w600)
                        ..textColor(Colors.black),
                    ),
                    Txt(
                      category.job,
                      style: TxtStyle()
                        ..textColor(const Color(0xff5d5ba3))
                        ..fontWeight(FontWeight.bold)
                        ..fontSize(12)
                        ..margin(top: 4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
