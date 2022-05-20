import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    const Color primary = Color.fromRGBO(118, 181, 197, 1.0);
    const Color textColor = Color(0xff464646);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
              color: Colors.black,),
              onPressed: () {  },
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Profile",
            ),
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
                  // Stack(
                  //   children: [
                  //     CardIconButton(Icons.arrow_back),
                  //     Container(
                  //       height: 40,
                  //       child: Center(
                  //         child: Text(
                  //           "Profile",
                  //           style: TextStyle(
                  //             color: textColor,
                  //             fontSize: 22,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      _makeCircle(200),
                      _makeCircle(170),
                      _makeCircle(140),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset("assets/images/profile.png",height: 120,width: 120,),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                   const Text(
                    "Binamrata Limbu",
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        _getCard("Privacy & Setting", Icons.lock_outline),
                        _getCard("Notification", Icons.notifications_active_outlined),
                        _getCard("My Prescription", Icons.medical_services_outlined),
                        _getCard("My Appointment", Icons.app_blocking),
                        _getCard("History", Icons.watch_later_outlined),
                        _getCard("Location", Icons.location_on_outlined),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primary.withAlpha(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 25, color: primary,),
                          const SizedBox(width: 10,),
                          Text("Sign Out", style: TextStyle(color: primary, fontSize: 18),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _makeCircle(double size) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size),
          border: Border.all(
            width: 2,
            color: Color.fromRGBO(118, 181, 197, 0.3),
          )),
    );
  }

  Widget _getCard(String text, IconData icon) {
    const Color color = Color.fromRGBO(118, 181, 197, 1.0);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color.withAlpha(40),
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff464646),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: color,
              ),
            ),
          )
        ],
      ),
    );
  }
}
