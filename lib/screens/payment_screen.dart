import 'package:division/division.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

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
                  colors: [Color(0xff83EAF1), Color(0xff63A4FF)]),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.white,
                      ),
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
                  'Rs. 3,200',
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
                          Image.asset('assets/images/payment.png'),
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
                              ..margin(top: 18, left: 22, right: 22)
                              ..background.color(Colors.white)
                              ..boxShadow(
                                color: const Color(0xffdddef2),
                                blur: 20,
                                offset: const Offset(0, 10),
                              )
                              ..borderRadius(all: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/esewa.png',
                                ),
                                Txt(
                                  'Esewa ',
                                  style: TxtStyle()
                                    ..textColor(Colors.black)
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.bold),
                                ),
                              ],
                            ),
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
                                Image.asset(
                                  'assets/images/khalti.png',
                                ),
                                Txt(
                                  'Khalti ',
                                  style: TxtStyle()
                                    ..textColor(Colors.black)
                                    ..fontSize(22)
                                    ..fontWeight(FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Center(
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
