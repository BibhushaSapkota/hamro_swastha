import 'package:flutter/material.dart';
import 'package:mero_doctor/models/category.dart';
import 'package:mero_doctor/screens/doctor_dashboard.dart';


class doctorView extends StatelessWidget {
  final DoctorWidgets details;
  const doctorView(this.details, {Key? key}) : super(key: key);

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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const DoctorDashboardScreen()));
              // Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text("View Profile"),
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        body: SizedBox(
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
                        backgroundColor: Colors.grey[800],
                        backgroundImage: AssetImage(details.image),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "$details.name",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
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
                          children: const [
                            Text(
                              "Dummy text",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Phone Number : ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "9826770332",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Email :",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(6.0),
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
                              child: SizedBox(
                                height: 90,
                                width: 310,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Image.asset("assets/images/wave.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
