import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'dashhboard_screen.dart';

class doctorView extends StatefulWidget {
  const doctorView({Key? key}) : super(key: key);

  @override
  State<doctorView> createState() => _doctorViewState();
}

class _doctorViewState extends State<doctorView> {
  get profilePicture => null;
  get id => null;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    const Color primary = Color.fromRGBO(118, 181, 197, 1.0);
    const Color textColor = Color(0xff464646);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                            id: id,
                            profileUrl: profilePicture,
                          )),
                  (route) => false);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("View Profile"),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Container(
          height: screen.height,
          width: screen.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  width: 180,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        child: Image.asset("assets/images/doctor_view.png"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Mr. Anup Burlakoti",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Stack(
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bio",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dummy text",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Phone NUmber : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "9826770332",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  "tsaroj895@gmail.com",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                                child: Container(
                                  height: 90,
                                  width: 310,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child:
                                        Image.asset("assets/images/wave.png"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
