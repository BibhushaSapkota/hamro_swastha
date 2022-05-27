import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screen=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  right: 0,
                  child: Image.asset('assets/images/Vector.png',fit: BoxFit.cover, width: screen.width),
                ),
                Txt('Personal Data',style: TxtStyle()
                  ..fontSize(24)
                  ..padding(left: 16)
                  ..fontFamily('quicksand')
                  ..fontWeight(FontWeight.bold)
                  ..textColor(const Color(0xff76B5C5))
                  ,),
                Txt('Profile Picture',style: TxtStyle()
                  ..fontSize(20)
                  ..fontFamily('quicksand')
                  ..padding(left: 16)
                  ..fontWeight(FontWeight.bold)
                  ..textColor(Colors.black)
                  ,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.asset("assets/images/profile.png",height: 70,width: 70,),
                      ),
                      Parent(style: ParentStyle()
                        ..height(44)
                        ..elevation(3,color: Colors.black12)
                        ..width(170)
                        ..borderRadius(all: 16)
                        ..background.color(const Color(0xff76B5C5))
                          ,
                          child:Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_upward,size: 22,color: Colors.white,),
                                Txt('Upload Picture',style: TxtStyle()
                                  ..fontSize(18)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..textColor(Colors.white)
                                  ,),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                Txt('Are you ____________ ?',style: TxtStyle()
                  ..fontSize(18)
                  ..fontFamily('quicksand')
                  ..padding(left: 16)
                  ..textColor(Colors.black)
                  ,),

                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: 1, groupValue: 1, onChanged: (value){},
                              activeColor: const Color(0xff76B5C5),
                            ),
                            SizedBox(width: 10,),
                            Text('Medical Officer'),

                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2, groupValue: 2, onChanged: (value){},
                            ),
                            SizedBox(width: 10,),
                            Text('Medical Officer'),

                          ],
                        ),
                        Txt('Your Specialization ',style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black)
                          ,),
                        SizedBox(height: 6,),
                        Parent(style: ParentStyle()
                          ..height(42)
                          ..elevation(3,color: Colors.black12)
                          ..width(screen.width)
                          ..margin(left: 16,right: 16)
                          ..borderRadius(all: 16)
                          ..background.color(const Color(0xff76B5C5))
                          ,
                          child:Row(
                            children: [
                              Txt('Cardiologist',style: TxtStyle()
                                ..fontSize(18)
                                ..fontFamily('quicksand')
                                ..padding(left: 90)
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.white)
                                ,),
                              Icon(Icons.arrow_drop_down_sharp,size: 22,color: Colors.white,),
                            ],
                          ),
                        ),
                        SizedBox(height: 6,),
                        Txt('Upload Your identification ',style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black)
                          ,),
                        SizedBox(height: 6,),
                        Parent(style: ParentStyle()
                          ..height(40)
                          ..elevation(3,color: Colors.black12)
                          ..width(160)
                          ..margin(left: 160)
                          ..borderRadius(all: 16)
                          ..background.color(const Color(0xff76B5C5))
                          ,
                          child:Txt('Choose a file',style: TxtStyle()
                            ..fontSize(16)
                            ..padding(left: 30,top: 10)
                            ..fontFamily('quicksand')
                            ..fontWeight(FontWeight.bold)
                            ..textColor(Colors.white)
                            ,),
                        ),
                        SizedBox(height: 6,),
                        Txt('Upload Your Doctor license ',style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black)
                          ,),
                        SizedBox(height: 6,),
                        Parent(style: ParentStyle()
                          ..height(40)
                          ..elevation(3,color: Colors.black12)
                          ..width(160)
                          ..margin(left: 160)
                          ..borderRadius(all: 16)
                          ..background.color(const Color(0xff76B5C5))
                          ,
                          child:Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: [
                                Txt('Choose a file',style: TxtStyle()
                                  ..fontSize(16)
                                  ..padding(left:26,)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..textColor(Colors.white)
                                  ,),],),


                          ),

                        ),
                        Center(
                          child: Parent(style: ParentStyle()
                            ..height(44)
                            ..elevation(3,color: Colors.black12)
                            ..width(136)
                            ..margin(top: 8)
                            ..borderRadius(all: 16)
                            ..background.color(const Color(0xffEFB492))
                            ,
                            child:Txt('Submit',style: TxtStyle()
                              ..fontSize(16)
                              ..fontFamily('quicksand')
                              ..fontWeight(FontWeight.bold)
                              ..padding(left: 42,top: 10)
                              ..textColor(Colors.white)
                              ,),
                          ),
                        ),
                      ]
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }
}
