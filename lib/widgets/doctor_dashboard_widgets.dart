import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/category.dart';

class DoctorDashBoardWidget extends StatelessWidget {
  final DoctorWidgets category;

  const DoctorDashBoardWidget(this.category) : super();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Parent(
        style: ParentStyle()
          ..borderRadius(all: 10)
          ..height(80)
          ..background.color(Colors.white)
          ..elevation(3, color: Colors.grey.shade300)
          ..padding(all: 12)
          ..margin(bottom: 12)
          ..width(screen.width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                print("pressed");
                Navigator.of(context).pushNamed("/docorview");
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(category.image),
              ),
            ),
            Column(
              children: [
                Txt(
                  category.name,
                  style: TxtStyle()
                    ..fontSize(16)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
                Txt(
                  category.time,
                  style: TxtStyle()
                    ..fontSize(16)
                    ..textColor(Colors.black)
                    ..fontFamily('quicksand'),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Parent(
                  style: ParentStyle()
                    ..height(24)
                    ..elevation(3)
                    ..background.color(const Color(0xff76B5C5))
                    ..width(60)
                    ..elevation(3)
                    ..borderRadius(all: 12),
                  child: Txt(
                    'Accept',
                    style: TxtStyle()
                      ..fontSize(13)
                      ..textColor(Colors.white)
                      ..alignmentContent.center(),
                  ),
                ),
                Parent(
                    style: ParentStyle()
                      ..height(24)
                      ..elevation(3)
                      ..background.color(Colors.red)
                      ..width(60)
                      ..elevation(3)
                      ..borderRadius(all: 12),
                    child: Txt(
                      'Decline',
                      style: TxtStyle()
                        ..fontSize(13)
                        ..textColor(Colors.white)
                        ..alignmentContent.center(),
                    ))
              ],
            )
          ],
        ));
  }
}
