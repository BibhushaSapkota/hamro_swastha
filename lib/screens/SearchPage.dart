// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/models/Customer.dart';
// import 'package:demo/models/chatRoom.dart';
// import 'package:demo/models/doctor.dart';
// import 'package:demo/provider/google_sign_in.dart';
// import 'package:demo/screens/authenticate/login.dart';
// import 'package:demo/screens/doctor_profile_screen.dart';
// import 'package:demo/screens/home/chatRoom.dart';
// import 'package:demo/services/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:uuid/uuid.dart';

// class Messenger extends StatefulWidget {
//   const Messenger({Key? key}) : super(key: key);

//   @override
//   _MessengerState createState() => _MessengerState();
// }

// class _MessengerState extends State<Messenger> {
//   var uid = Uuid();
//   AuthServices _auth = AuthServices();
//   Customer customer = Customer();
//   final CollectionReference data =
//       FirebaseFirestore.instance.collection('Customer');

//   TextEditingController _textEditingController = TextEditingController();

//   List<Customer> AllDoctorOnSearch = [];

//   List<Customer> AllDoctor = [];

//   final User? user = FirebaseAuth.instance.currentUser;

//   Future<ChatRoomModel?> getChatRoomModel(Customer targetUser) async {
//     ChatRoomModel? chatRoom;

//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('chatrooms')
//         .where("participants.${user!.uid}", isEqualTo: true)
//         .where("participants.${targetUser.uid}", isEqualTo: true)
//         .get();

//     if (snapshot.docs.length > 0) {
//       // log("Chat Room Exists");
//       var docData = snapshot.docs[0].data();
//       ChatRoomModel existingChatRoom =
//           ChatRoomModel.fromMap(docData as Map<String, dynamic>);
//       log('Chat room Exists!');
//       // print('My id........');
//       // print(user?.uid);
//       // print('Targets id......');
//       // print(targetUser.uid);
//       chatRoom = existingChatRoom;
//     } else {
//       ChatRoomModel newChatRoom = ChatRoomModel(
//           chatroomId: uid.v1(),
//           lastMessage: "",
//           roomCreated: DateTime.now(),
//           participants: {
//             user!.uid.toString(): true,
//             targetUser.uid.toString(): true,
//           });

//       await FirebaseFirestore.instance
//           .collection("chatrooms")
//           .doc(newChatRoom.chatroomId)
//           .set(newChatRoom.toMap());
//       log('New Chat room created!');
//       chatRoom = newChatRoom;
//     }

//     return chatRoom;
//   }

//   @override
//   void initState() {
//     super.initState();
//     data.get().then((value) => {
//           value.docs.forEach((element) {
//             customer = Customer.fromMap(element.data());
//             setState(() {
//               String? id;
//               if (customer.uid != null) {
//                 id = customer.uid;
//               }
//               // print('All Id.......');
//               // print(id);
//               String? name = customer.first_name;
//               String? image = customer.imageURL1;
//               this.AllDoctor.add(Customer(
//                     uid: customer.uid,
//                     first_name: customer.first_name,
//                     last_name: customer.last_name,
//                     email: customer.email,
//                     imageURL1: customer.imageURL1,
//                     imageURL2: customer.imageURL2,
//                     isCustomer: customer.isCustomer,
//                     isNormalUser: customer.isNormalUser,
//                     isGoogleUser: customer.isGoogleUser,
//                     isFormCompleted: customer.isFormCompleted,
//                   ));
//               // this.AllDoctor.add(Doctor(id!, name!, image!, "orgName",
//               //     "qualification", "123123", "description"));
//             });
//           })
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextField(
//             onChanged: (value) {
//               setState(() {
//                 AllDoctorOnSearch = AllDoctor.where((element) => element
//                     .first_name!
//                     .toLowerCase()
//                     .contains(value.toLowerCase())).toList();

//                 // foodonSearch = food
//                 //     .where((element) =>
//                 //         element.toLowerCase().contains(value.toLowerCase()))
//                 //     .toList();
//               });
//               // print(_textEditingController.text);
//               // if (_textEditingController.text.isEmpty) {
//               //   print('Empty');
//               // } else {
//               //   print('Not Empty');
//               // }
//               // print(foodonSearch.length);
//             },
//             controller: _textEditingController,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               errorBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               hintText: 'Search',
//             )),
//         actions: [
//           Center(
//             child: FlatButton.icon(
//                 color: Colors.pink,
//                 onPressed: () async {
//                   _auth.SignOut();
//                   final provider =
//                       Provider.of<GoogleSignInProvider>(context, listen: false);
//                   provider.logout();
//                   Navigator.popUntil(context, (route) => route.isFirst);
//                   Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (context) => const Login()));
//                 },
//                 icon: const Icon(Icons.logout),
//                 label: const Text('Log Out')),
//           ),
//         ],
//       ),
//       body: _textEditingController.text.isEmpty || AllDoctorOnSearch.length == 0
//           ? Center(
//               child: Text('No Result found!'),
//             )
//           : ListView.builder(
//               itemCount: _textEditingController.text.isNotEmpty
//                   ? AllDoctorOnSearch.length
//                   : AllDoctor.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () async {
//                     ChatRoomModel? chatRoomModel =
//                         await getChatRoomModel(AllDoctorOnSearch[index]);

//                     if (chatRoomModel != null) {
//                       // print(AllDoctorOnSearch[index].name);
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) => DoctorProfileScreen(
//                       //             doctor: AllDoctorOnSearch[index])));
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ChatRoom(
//                                     username:
//                                         AllDoctorOnSearch[index].first_name!,
//                                     targetUser: AllDoctorOnSearch[index],
//                                     chatroom: chatRoomModel,
//                                   )));
//                     }
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                     child: Row(
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.green[100],
//                           backgroundImage:
//                               NetworkImage(AllDoctorOnSearch[index].imageURL1!),
//                           // child: Image.network(AllDoctorOnSearch[index].image),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           _textEditingController.text.isNotEmpty
//                               ? AllDoctorOnSearch[index].first_name!
//                               : AllDoctor[index].first_name!,
//                           // ? foodonSearch[index]
//                           // : food[index],
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//     );
//   }
// }
