import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:division/division.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/chatRoom.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/chatRoomDoctor.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:uuid/uuid.dart';

class SearchPagePatient extends StatefulWidget {
  const SearchPagePatient({Key? key}) : super(key: key);

  @override
  _SearchPagePatientState createState() => _SearchPagePatientState();
}

class _SearchPagePatientState extends State<SearchPagePatient> {
  var uid = const Uuid();

  UserModel patient = UserModel();
  final CollectionReference data =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _textEditingController = TextEditingController();

  List<UserModel> AllPatientOnSearch = [];

  List<UserModel> AllPatient = [];

  final User? user = FirebaseAuth.instance.currentUser;

  Future<ChatRoomModel?> getChatRoomModel(UserModel targetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .where("participants.${user!.uid}", isEqualTo: true)
        .where("participants.${targetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // log("Chat Room Exists");
      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatRoom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      log('Chat room Exists!');
      // print('My id........');
      // print(user?.uid);
      // print('Targets id......');
      // print(targetUser.uid);
      chatRoom = existingChatRoom;
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
          chatroomId: uid.v1(),
          lastMessage: "",
          roomCreated: DateTime.now(),
          participants: {
            user!.uid.toString(): true,
            targetUser.uid.toString(): true,
          });

      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatroomId)
          .set(newChatRoom.toMap());
      log('New Chat room created!');
      chatRoom = newChatRoom;
    }

    return chatRoom;
  }

  @override
  void initState() {
    super.initState();
    print(user?.uid);
    data.get().then((value) => {
          value.docs.forEach((element) {
            patient = UserModel.fromMap(element.data());
            setState(() {
              // String? id;
              // id = patient.uid!;
              // print('All Id.......');
              // print(id);
              String? name = patient.firstName;
              String? image = patient.lastName;
              AllPatient.add(UserModel(
                uid: patient.uid,
                firstName: patient.firstName,
                lastName: patient.lastName,
                email: patient.email,
                profilePicture: patient.profilePicture,
                isPatient: patient.isPatient,
                bookMarked: patient.bookMarked,
                oldReportFile: patient.oldReportFile,
                isGoogleUser: patient.isGoogleUser,
                isFormCompleted: patient.isFormCompleted,
              ));
              // this.AllPatient.add(Doctor(id!, name!, image!, "orgName",
              //     "qualification", "123123", "description"));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: COLOR_SECONDARY,
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                    color: Colors.grey.withOpacity(0.23),
                  )
                ]),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        print('asd');
                        setState(() {
                          AllPatientOnSearch = AllPatient.where((element) =>
                              element.firstName!
                                  .toLowerCase()
                                  .contains(value.toLowerCase())).toList();
                        });
                      },
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Search for a patient.',
                        hintStyle: TextStyle(
                          fontFamily: 'quicksand',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontFamily: 'quicksand',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Parent(
                  style: ParentStyle()
                    ..height(60)
                    ..width(70)
                    ..background.color(const Color(0xfff58173))
                    ..borderRadius(all: 40),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _textEditingController.text.isEmpty || AllPatientOnSearch.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text('No Result found!'),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _textEditingController.text.isNotEmpty
                          ? AllPatientOnSearch.length
                          : AllPatient.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            ChatRoomModel? chatRoomModel =
                                await getChatRoomModel(
                                    AllPatientOnSearch[index]);

                            if (chatRoomModel != null) {
                              print(AllPatientOnSearch[index].firstName);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DoctorProfileScreen(
                              //             doctor: AllPatientOnSearch[index])));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoomDoctor(
                                            username: AllPatientOnSearch[index]
                                                .firstName!,
                                            targetUser:
                                                AllPatientOnSearch[index],
                                            chatroom: chatRoomModel,
                                          )));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Row(
                              children: [
                                AllPatientOnSearch[index].profilePicture! != ""
                                    ? CircleAvatar(
                                        backgroundColor: Colors.green[100],
                                        backgroundImage: NetworkImage(
                                            AllPatientOnSearch[index]
                                                .profilePicture!),
                                        // child: Image.network(AllPatientOnSearch[index].image),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.green[100],
                                        backgroundImage: const AssetImage(
                                            "assets/images/profile.jpg"),
                                        // child: Image.network(AllPatientOnSearch[index].image),
                                      ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _textEditingController.text.isNotEmpty
                                      ? AllPatientOnSearch[index].firstName!
                                      : AllPatient[index].firstName!,
                                  // ? foodonSearch[indexlastName
                                  // : food[index],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
        ]));
  }
}
