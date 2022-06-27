import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/chatRoom.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/SearchPage.dart';
import 'package:mero_doctor/screens/chatRoomDoctor.dart';
import 'package:uuid/uuid.dart';

class MessagePageDoctor extends StatefulWidget {
  const MessagePageDoctor({Key? key}) : super(key: key);

  @override
  _MessagePageDoctorState createState() => _MessagePageDoctorState();
}

class _MessagePageDoctorState extends State<MessagePageDoctor> {
  User? user = FirebaseAuth.instance.currentUser;
  var uuid = Uuid();
  bool isDoctor = false;
  UserModel patient = UserModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference CustomerUserdata =
      FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('printed1');
  }

  Future getCustomerById(String uid) async {
    UserModel? patient;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap != null) {
      patient = UserModel.fromMap(docSnap.data());
      // print(patient.first_name);
    }

    return patient!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchPagePatient()),
                );
              },
              child: Text('Search'))
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

                        List<String> participants_keys =
                            participants.keys.toList();

                        participants_keys.remove(user?.uid);
                        print(
                            "Participants Keys..............................");
                        print(participants_keys);

                        return FutureBuilder(
                            future: getCustomerById(participants_keys[0]),
                            builder: (context, userData) {
                              if (userData.connectionState ==
                                  ConnectionState.done) {
                                if (userData.data != null) {
                                  UserModel targetPatient =
                                      userData.data as UserModel;
                                  // DoctorModel targetPatient =
                                  //     userData.data as DoctorModel;

                                  return ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ChatRoomDoctor(
                                              targetUser: targetPatient,
                                              chatroom: chatRoomModel,
                                              username: targetPatient.firstName
                                                  .toString());
                                        }));
                                      },
                                      leading: targetPatient.profilePicture
                                                  .toString() ==
                                              ""
                                          ? CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: AssetImage(
                                                  "assets/images/google.png"),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.green[100],
                                              backgroundImage: NetworkImage(
                                                  targetPatient.profilePicture
                                                      .toString()),
                                            ),
                                      title: Text(
                                          targetPatient.firstName.toString()),
                                      subtitle: (chatRoomModel.lastMessage
                                                  .toString() !=
                                              "")
                                          ? Text(chatRoomModel.lastMessage
                                              .toString())
                                          : Text(
                                              "Say hi to your new friend!",
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
