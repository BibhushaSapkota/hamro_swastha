import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/screens/calender_screen.dart';
import 'package:mero_doctor/screens/payment.dart';

class PaymentScreen extends StatefulWidget {
  String? profileUrl;
  PaymentScreen(
      {Key? key,
      required this.doctor,
      required this.appointmentDate,
      required this.selectedDate,
      required this.selectedIndex,
      this.profileUrl})
      : super(key: key);
  final Doctor doctor;
  List<String> appointmentDate = [];

  int selectedIndex = -1;

  String selectedDate = "";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String? getPay = "10";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          Container(
            height: screen.height,
            width: screen.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff83EAF1),
                  Color(0xff63A4FF),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => CalenderScreen(
                                          doctor: widget.doctor,
                                          profileUrl: widget.profileUrl,
                                        )),
                                (route) => false);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 32,
                            color: Colors.white,
                          )),
                      Image.asset(
                        'assets/images/scan.png',
                        height: 35,
                        width: 35,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Txt(
                  '$getPay',
                  style: TxtStyle()
                    ..textColor(Colors.white)
                    ..fontSize(25)
                    ..margin(left: 16, top: 16)
                    ..fontWeight(FontWeight.bold),
                ),
                Txt(
                  'Your total',
                  style: TxtStyle()
                    ..textColor(Colors.white)
                    ..fontSize(16)
                    ..margin(left: 16),
                ),
                Expanded(
                  child: Parent(
                      style: ParentStyle()
                        ..width(screen.width)
                        ..margin(top: 32)
                        ..background.color(Colors.white)
                        ..borderRadius(topRight: 28, topLeft: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            'Cards',
                            style: TxtStyle()
                              ..textColor(Colors.black)
                              ..fontSize(24)
                              ..margin(left: 24, top: 16)
                              ..fontWeight(FontWeight.bold),
                          ),
                          Image.asset(
                            'assets/images/payment.png',
                            height: screen.height / 3,
                          ),
                          Txt(
                            'Payment Methods',
                            style: TxtStyle()
                              ..textColor(Colors.black)
                              ..fontSize(22)
                              ..margin(left: 24, top: 12)
                              ..fontWeight(FontWeight.bold),
                          ),
                          Parent(
                            style: ParentStyle()
                              ..height(70)
                              ..width(screen.width)
                              ..margin(top: 30, left: 22, right: 22)
                              ..background.color(Colors.white)
                              ..boxShadow(
                                color: const Color(0xffdddef2),
                                blur: 10,
                                offset: const Offset(0, 10),
                              )
                              ..borderRadius(all: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                KhaltiPaymentPage(
                                                    getPay: getPay,
                                                    appointmentDate: widget
                                                        .appointmentDate,
                                                    doctor: widget.doctor,
                                                    selectedDate: widget
                                                        .selectedDate,
                                                    selectedIndex:
                                                        widget.selectedIndex,
                                                    profileUrl:
                                                        widget.profileUrl)),
                                        (route) => false);
                                  },
                                  child:
                                      Image.asset('assets/images/khalti.png'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              "Powered by Mero Health",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
