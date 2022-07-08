import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/utils/constants.dart';

class TrasnactionHistoryPage extends StatefulWidget {
  const TrasnactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TrasnactionHistoryPageState createState() => _TrasnactionHistoryPageState();
}

class _TrasnactionHistoryPageState extends State<TrasnactionHistoryPage> {
  User? user = FirebaseAuth.instance.currentUser!;
  UserModel userModel = UserModel();
  TransactionData transactionData = TransactionData();
  String? transaction_date;
  String? transaction_amount;
  String? appointment_date;
  bool? isPaymentDone;
  String? transaction_time;
  String? time_slot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
  }

  getTransaction() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromMap(value.data());
      for (int i = 0; i < userModel.transaction!.length; i++) {
        setState(() {
          transactions.add(userModel.transaction![i]);
          transactionData = TransactionData.fromMap(
              userModel.transaction![i] as Map<String, dynamic>);
          transaction_date = transactionData.transaction_date;
          transaction_amount = transactionData.transaction_amount;
          appointment_date = transactionData.appointment_date.toString();
          isPaymentDone = transactionData.isPaymentDone;
          transaction_time = transactionData.transaction_time;
          time_slot = transactionData.time_slot;
        });
      }
    });
  }

  List transactions = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: COLOR_SECONDARY,
              title: const Text(
                "Transaction",
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            body: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: ((context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 236, 236),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 130.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Appointment date: ${appointment_date}")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Appointment Time-Slot: ${time_slot}")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Amount : Rs.${transaction_amount}")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  "Transaction date: ${transaction_date}, ${transaction_time}")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  );
                }))));
  }
}
