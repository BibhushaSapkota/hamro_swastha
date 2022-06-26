// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/models/Customer.dart';
// import 'package:demo/models/chatRoom.dart';
// import 'package:demo/screens/home/SearchPage.dart';
// import 'package:demo/screens/home/SearchPageDoctor.dart';
// import 'package:demo/screens/home/chatRoom.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   User? user = FirebaseAuth.instance.currentUser;
//   var uuid = Uuid();
//   bool isDoctor = false;
//   Customer customer = Customer();
//   DoctorModel doctor = DoctorModel();
//   User? firebaseUser = FirebaseAuth.instance.currentUser;
//   final CollectionReference CustomerUserdata =
//       FirebaseFirestore.instance.collection('Customer');
//   final CollectionReference DoctorUserdata =
//       FirebaseFirestore.instance.collection('doctor');

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print('printed1');
//   }

//   Future<bool> getId(String uid) async {
//     bool isCustomer = false;

//     await CustomerUserdata.doc(uid).get().then((value) {
//       if (value.exists) {
//         isCustomer = true;
//       }
//     });

//     return isCustomer;
//   }

//   Future getCustomerById(String uid) async {
//     Customer? customer;

//     DocumentSnapshot docSnap =
//         await FirebaseFirestore.instance.collection("Customer").doc(uid).get();

//     if (docSnap != null) {
//       customer = Customer.fromMap(docSnap.data());
//       // print(customer.first_name);
//     }

//     return customer!;
//   }

//   Future getDoctorById(String uid) async {
//     DoctorModel? doctor;

//     DocumentSnapshot docSnap =
//         await FirebaseFirestore.instance.collection("doctor").doc(uid).get();

//     if (docSnap != null) {
//       doctor = DoctorModel.fromMap(docSnap.data());
//       // print(customer.first_name);
//     }

//     return doctor!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           FlatButton(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => Messenger()),
//                 );
//               },
//               child: Text('Search'))
//         ],
//       ),
//       body: SafeArea(
//         child: Container(
//           child: StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection("chatrooms")
//                 .where("participants.${user!.uid}", isEqualTo: true)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.hasData) {
//                   QuerySnapshot chatRoomSnapshot =
//                       snapshot.data as QuerySnapshot;

//                   return ListView.builder(
//                       itemCount: chatRoomSnapshot.docs.length,
//                       itemBuilder: (context, index) {
//                         ChatRoomModel chatRoomModel = ChatRoomModel.fromMap(
//                             chatRoomSnapshot.docs[index].data()
//                                 as Map<String, dynamic>);

//                         Map<String, dynamic> participants =
//                             chatRoomModel.participants!;

//                         List<String> participants_keys =
//                             participants.keys.toList();

//                         participants_keys.remove(user?.uid);
//                         print(
//                             "Participants Keys..............................");
//                         print(participants_keys);

//                         bool isCustomer = false;
//                         getId(participants_keys[0]).then((value) {
//                           isCustomer = value;
//                           print('Customer TRUE OR FALSE');
//                           print(isCustomer);
//                         });

//                         return FutureBuilder(
//                             future: getCustomerById(participants_keys[0]),
//                             builder: (context, userData) {
//                               if (userData.connectionState ==
//                                   ConnectionState.done) {
//                                 if (userData.data != null) {
//                                   Customer targetDoctoreUser =
//                                       userData.data as Customer;
//                                   // DoctorModel targetDoctoreUser =
//                                   //     userData.data as DoctorModel;

//                                   return ListTile(
//                                       onTap: () {
//                                         Navigator.push(context,
//                                             MaterialPageRoute(
//                                                 builder: (context) {
//                                           return ChatRoom(
//                                               targetUser: targetDoctoreUser,
//                                               chatroom: chatRoomModel,
//                                               username: targetDoctoreUser
//                                                   .first_name
//                                                   .toString());
//                                         }));
//                                       },
//                                       leading: targetDoctoreUser.imageURL1
//                                                   .toString() ==
//                                               ""
//                                           ? CircleAvatar(
//                                               backgroundColor:
//                                                   Colors.green[100],
//                                               backgroundImage: AssetImage(
//                                                   "assets/images/google.png"),
//                                             )
//                                           : CircleAvatar(
//                                               backgroundColor:
//                                                   Colors.green[100],
//                                               backgroundImage: NetworkImage(
//                                                   targetDoctoreUser.imageURL1
//                                                       .toString()),
//                                             ),
//                                       title: Text(targetDoctoreUser.first_name
//                                           .toString()),
//                                       subtitle: (chatRoomModel.lastMessage
//                                                   .toString() !=
//                                               "")
//                                           ? Text(chatRoomModel.lastMessage
//                                               .toString())
//                                           : Text(
//                                               "Say hi to your new friend!",
//                                               style: TextStyle(
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .secondary),
//                                             ));
//                                 } else {
//                                   return Container();
//                                 }
//                               } else {
//                                 return Container();
//                               }
//                             });

//                         // retu
//                       });
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(snapshot.error.toString()),
//                   );
//                 } else {
//                   return const Center(
//                     child: Text('No Chats'),
//                   );
//                 }
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
