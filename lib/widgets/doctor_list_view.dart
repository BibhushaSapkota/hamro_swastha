import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/screens/doctor_profile_screen.dart';

class DoctorListView extends StatelessWidget {
  final Doctor doctor;
  const DoctorListView(this.doctor) : super();

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorProfileScreen(doctor: doctor)));
      },
      child: Parent(
        style: ParentStyle()
          ..height(84)
          ..borderRadius(all: 10)
          ..margin(top: 10)
          ..width(screen.width)
          ..elevation(3, color: Colors.grey.shade200)
          ..background.color(const Color(0xfff9f3eb)),
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
                      ..background.color(const Color(0xffffb060))),
                Image.network(
                  doctor.image,
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
                      doctor.name,
                      style: TxtStyle()
                        ..fontSize(16)
                        ..textColor(const Color(0xff7f819b))
                        ..fontWeight(FontWeight.w600)
                        ..textColor(Colors.black),
                    ),
                    Txt(
                      doctor.specialization,
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
        ),
      ),
    );
  }
}
