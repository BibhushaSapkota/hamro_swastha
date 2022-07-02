import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/chatRoom.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mero_doctor/models/models.dart';
import 'package:mero_doctor/screens/calender_screen.dart';
import 'package:mero_doctor/screens/chatRoomPatient.dart';
import 'package:mero_doctor/screens/dashhboard_screen.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:uuid/uuid.dart';

class DoctorProfileScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() =>
      _DoctorProfileScreenState(doctor: doctor);
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  var uuid = const Uuid();
  final Doctor doctor;
  User? user = FirebaseAuth.instance.currentUser;
  _DoctorProfileScreenState({Key? key, required this.doctor});

  // Creating CHatRoom For two User
  Future<ChatRoomModel?> getChatRoomModel(Doctor targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where("participants.${user!.uid}", isEqualTo: true)
        .where("participants.${targetUser.id}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      print("Chat Room Exists");
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      // print('My id........');
      // print(user?.uid);
      // print('Targets id......');
      // print(targetUser.uid);
      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatroomId: uuid.v1(),
          lastMessage: "",
          roomCreated: DateTime.now(),
          participants: {
            user!.uid.toString(): true,
            targetUser.id.toString(): true,
          });

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatroomId)
          .set(newChatRoom.toMap());
      print("New Chat room created!");
      chatRoom = newChatRoom;
    }

    return chatRoom;
  }

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEFB492),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                color: const Color(0xffEFB492),
                padding: const EdgeInsets.all(40),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen(
                                        id: user!.uid,
                                        profileUrl: widget.doctor.image,
                                      )),
                              (route) => false);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: widget.doctor.image == ""
                          ? const CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                "assets/images/profile.jpg",
                              ))
                          : CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(widget.doctor.image),
                            ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: screen.width,
                  height: screen.height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -40,
                        left: (screen.width / 2) - 125,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: COLOR_SECONDARY,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          width: 250,
                          child: Column(
                            children: [
                              Text(
                                widget.doctor.name,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                widget.doctor.orgName,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                              Text(
                                widget.doctor.specialization,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        child: SizedBox(
                          width: screen.width,
                          height: screen.height,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: screen.width / 2 - 30,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.video_call,
                                          size: 24.0,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: COLOR_SECONDARY,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        label: const Text('Video Call'),
                                      ),
                                    ),
// ------------------------------------ Chat function ------------------------------------
                                    SizedBox(
                                      height: 50,
                                      width: screen.width / 2 - 30,
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          ChatRoomModel? chatRoomModel =
                                              await getChatRoomModel(doctor);
                                          if (chatRoomModel != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatRoomPatient(
                                                          username: doctor.name,
                                                          targetUser: doctor,
                                                          chatroom:
                                                              chatRoomModel,
                                                        )));
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.chat,
                                          size: 24.0,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: COLOR_SECONDARY,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50))),
                                        label: const Text('Chat'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.doctor.orgName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      updateOnDrag: true,
                                      onRatingUpdate: (rating) => setState(
                                        () {
                                          this.rating = rating;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "About " + widget.doctor.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.doctor.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Upcoming schedule",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Stack(
                                  children: [
                                    Align(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffa69d9d),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset((0), 3),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(15),
                                        width: screen.width - 100,
                                        child: Column(
                                          children: const [
                                            Text(
                                              "Consultant",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "Sunday 9 AM - 11 AM",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      alignment: Alignment.centerRight,
                                    ),
                                    Positioned(
                                      top: 16,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: const Color(0xffC5DFA4),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          "June 13",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Center(
                                    child: MaterialButton(
                                      onPressed: () {},
                                      color: COLOR_SECONDARY,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      minWidth: screen.width / 2,
                                      height: 50,
                                      child: GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CalenderScreen(
                                                      doctor: widget.doctor),
                                            ),
                                          )
                                        },
                                        child: const Text(
                                          "Book an Appointment",
                                          style: TextStyle(
                                              color: COLOR_WHITE, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
