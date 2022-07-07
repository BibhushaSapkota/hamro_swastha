import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/chatRoom.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/SearchPageDoctor.dart';
import 'package:mero_doctor/screens/chatRoomPatient.dart';
import 'package:mero_doctor/utils/capatalize.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:uuid/uuid.dart';

class PatientMessagePage extends StatefulWidget {
  const PatientMessagePage({Key? key}) : super(key: key);

  @override
  _PatientMessagePageState createState() => _PatientMessagePageState();
}

class _PatientMessagePageState extends State<PatientMessagePage> {
  User? user = FirebaseAuth.instance.currentUser;
  var uuid = const Uuid();
  DoctorModel doctor = DoctorModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference DoctorUserdata =
      FirebaseFirestore.instance.collection('doctor');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('printed1');
  }

  Future getDoctorById(String uid) async {
    DoctorModel? doctor;
    String id = "";
    String name = "";
    String image = "";
    String schedule = "";
    String orgName = "Not Specified";
    String position = "Not Specified";
    String description = "Not Specified";

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("doctors").doc(uid).get();

    doctor = DoctorModel.fromMap(docSnap.data());
    if (doctor.docid != "") {
      id = doctor.docid!;
    }
    if (doctor.firstName != "") {
      name = doctor.firstName!;
    }
    if (doctor.profileImageDownloadURL != "") {
      image = doctor.profileImageDownloadURL!;
    }
    if (doctor.description != null) {
      description = doctor.description!;
    }
    if (doctor.position != null) {
      position = doctor.position!;
    }
    if (doctor.specialization != null) {
      orgName = doctor.specialization!;
    }

    Doctor doctorData =
        Doctor(id, name, image, orgName, position, "12:00", description);

    print('Data inside list..............................');
    print(doctorData.id);

    return doctorData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_SECONDARY,
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchPageDoctor()),
                );
              },
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("chatrooms")
                .where("participants.${user!.uid}", isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  QuerySnapshot chatRoomSnapshot =
                      snapshot.data as QuerySnapshot;

                  return ListView.builder(
                      itemCount: chatRoomSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
                            chatRoomSnapshot.docs[index].data()
                                as Map<String, dynamic>);

                        Map<String, dynamic> participants =
                            chatRoomModel.participants!;

                        List<String> participantsKeys =
                            participants.keys.toList();

                        participantsKeys.remove(user?.uid);
                        print(
                            "Participants Keys..............................");
                        print(participantsKeys);

                        return FutureBuilder(
                            future: getDoctorById(participantsKeys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  // Customer targetDoctoreUser =
                                  //     userData.data as Customer;
                                  Doctor targetDoctoreUser =
                                      userData.data as Doctor;

                                  return ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ChatRoomPatient(
                                              targetUser: targetDoctoreUser,
                                              chatroom: chatRoomModel,
                                              username: targetDoctoreUser.name
                                                  .toString());
                                        }));
                                      },
                                      leading: targetDoctoreUser.image
                                                  .toString() ==
                                              ""
                                          ? const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 27, 216, 33),
                                              backgroundImage: AssetImage(
                                                  "assets/images/profile.jpg"),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: NetworkImage(
                                                  targetDoctoreUser.image
                                                      .toString()),
                                            ),
                                      title: Text(
                                        capitalize(
                                            targetDoctoreUser.name.toString()),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      subtitle: (chatRoomModel.lastMessage
                                                  .toString() !=
                                              "")
                                          ? Text(chatRoomModel.lastMessage
                                              .toString())
                                          : Text(
                                              "Say hi!",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                            ));
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            });

                        // retu
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: Text('No Chats'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
