
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class userHistory extends StatefulWidget {
  @override
  State<userHistory> createState() => _userHistoryState();
}

class _userHistoryState extends State<userHistory> {
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
            ), onPressed: () {
          },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Appointment history",style: TextStyle(fontSize: 20),
          ),
          foregroundColor: Colors.black,
          centerTitle: true,

        ),

        body: Container(
          height: screen.height/6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.lightBlueAccent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Image.asset("assets/images/ic_topDoctor2.png",width: 100,)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    Text("Doctor Name",
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                    SizedBox(height: 5,),
                    Text("Date : 2075/12/3",
                      style: TextStyle(
                        color: Colors.black,
                      ),),
                    SizedBox(height: 5,),
                    Text("Time : 9 AM",
                      style: TextStyle(
                        color: Colors.black,
                      ),),

                  ],

                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Column(
                  children: [
                    Transform.scale(
                      scale: 1.5,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ), onPressed: () {
                      },
                      ),

                    ),
                    Text("Cancel ",
                      style: TextStyle(
                          color: Colors.red
                      ),)
                  ],
                ),

              ),



            ],

          ),

        ),

      ),

    );
  }
}