import 'package:flutter/material.dart';

class patientProfile extends StatefulWidget {
  const patientProfile({Key? key}) : super(key: key);

  @override
  State<patientProfile> createState() => _patientProfileState();
}

class _patientProfileState extends State<patientProfile> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Positioned(
                child: Container(
                  height: 200,
                  width: screen.width,

                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/bak.png"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[800],
                        backgroundImage: AssetImage("assets/images/doctor_view.png"),
                        radius: 60,
                      ),
                      Text("Anup Burlakoti",style: TextStyle(color: Colors.white),)
                    ],
                  ),

                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_back,
                  color: Colors.black,),
                tooltip: 'Back button',
                onPressed: () {
                },
              ),

            ],


          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Email: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),

                  Text("dummyemail@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                    ),)
                ],

              ),

              SizedBox(height: 16,),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Contact: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),

                  Text("9800000000",
                    style: TextStyle(
                      fontSize: 14,
                    ),)
                ],

              ),

              SizedBox(height: 16,),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Report: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                  ),
                ],

              ),

            ],
          )
        ],
      ),



    );
  }
}
