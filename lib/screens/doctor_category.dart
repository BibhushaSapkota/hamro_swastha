import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DoctorCategoryScreen extends StatelessWidget {
  const DoctorCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screen.height,
          width: screen.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Txt('Doctor Categories',style: TxtStyle()
                ..fontSize(32)
                ..margin(left: 16,right: 16,top: 12)
                ..textColor(const Color(0xff76B5C5))
                ..fontWeight(FontWeight.bold)
                ,),
              SizedBox(height: 10,),
              Parent(style: ParentStyle()
              ..height(200)
                ..margin(left: 16,right: 16)
                ..background.color(const Color(0xff76B5C5))
                  ..width(screen.width),
                child:Image.asset('assets/images/categories2.png',fit: BoxFit.cover,),
              ),
          SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Parent(
                      style: ParentStyle()
                        ..height(110)
                        ..width(screen.width)
                        ..background.color(Colors.white)
                        ..boxShadow(
                          color: const Color(0xffdddef2),
                          blur: 10,
                          offset: const Offset(0, 10),
                        )
                        ..borderRadius(all: 15),
                      child:Row(
                        children: [
                          Stack(
                            children: [
                              Parent(style: ParentStyle()
                              ..height(80)
                                  ..width(80)
                                ..margin(left: 16)
                                ..borderRadius(all: 16)
                                  ..background.color(Colors.red),
                                child:Image.asset('assets/images/ic_topDoctor2.png',),

                              ),

                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16,left: 44),
                          child: Column(
                            children: [
                              Txt('Dr. Manish Sherma',style: TxtStyle()
                                ..fontSize(16)
                                ..textColor(Colors.black)
                                ..fontWeight(FontWeight.bold)
                                ,),
                              Txt('Cardiologits',style: TxtStyle()
                                ..fontSize(16)
                                ..textColor(Colors.black)
                                ..fontWeight(FontWeight.w300)
                                ,),

                              Txt('9:00-10:00',style: TxtStyle()
                                ..fontSize(16)
                                ..textColor(Colors.black)
                                ..fontWeight(FontWeight.w200)
                                ,),


                            ],
                          ),
                        )

                        ],
                      ) ,
                    ),
                  ],
                ),
              )


            ],
          ),


      ),
      ),
    );
  }
}
