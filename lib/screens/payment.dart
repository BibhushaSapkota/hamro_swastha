import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:mero_doctor/models/doctor.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/payment_screen.dart';
import 'package:mero_doctor/utils/snack_bar.dart';

class KhaltiPaymentPage extends StatefulWidget {
  String? profileUrl;
  KhaltiPaymentPage(
      {Key? key,
      this.getPay,
      required this.appointmentDate,
      required this.doctor,
      required this.selectedDate,
      required this.selectedIndex,
      this.profileUrl})
      : super(key: key);
  final String? getPay;
  final UserModel _userModel = UserModel();
  final Doctor doctor;
  List<String> appointmentDate = [];

  int selectedIndex = -1;

  String selectedDate = "";
  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;
  final CollectionReference data =
      FirebaseFirestore.instance.collection("doctors");
  @override
  void initState() {
    super.initState();
    amountController.text = "${widget.getPay}";
  }

  int getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  bookAppointment(String amount, String date, String time) async {
    if (widget.selectedIndex == -1) return;
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    UserModel userModel = UserModel.fromMap(user.data());
    String name = "${userModel.firstName}  ${userModel.lastName}";

    Map<String, dynamic> appointment = {
      'isPaymentDone': true,
      'transaction_amount': amount,
      'transaction_date': date,
      'transaction_time': time,
      "date": widget.selectedDate,
      "time": widget.appointmentDate[widget.selectedIndex],
      "username": name,
      "profilePicture": userModel.profilePicture ?? "",
    };

    try {
      await data
          .doc(widget.doctor.id)
          .collection('UpcomingAppointment')
          .add(appointment);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackMessage.successSnackBar("Appointment booked successfully!!"));
    } catch (ex) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackMessage.successSnackBar(ex.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Khalti Payment Integration',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF56328c),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                            appointmentDate: widget.appointmentDate,
                            doctor: widget.doctor,
                            selectedDate: widget.selectedDate,
                            selectedIndex: widget.selectedIndex,
                            profileUrl: widget.profileUrl,
                          )),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            // For Amount
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              readOnly: true,
              decoration: const InputDecoration(
                  labelText: "Enter Amount to pay",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            // For Button
            MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 50,
                color: const Color(0xFF56328c),
                child: const Text(
                  'Pay With Khalti',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  KhaltiScope.of(context).pay(
                    config: PaymentConfig(
                      amount: getAmt(),
                      productIdentity: 'BookingTransaction',
                      productName: 'Appointment',
                    ),
                    preferences: [
                      PaymentPreference.khalti,
                    ],
                    onSuccess: (su) {
                      var now = DateTime.now();
                      var dateFormater = DateFormat('yyyy/MM/dd');
                      String timeFormater = DateFormat('kk:mm a').format(now);
                      String formattedDate = dateFormater.format(now);
                      transaction(
                          formattedDate,
                          (getAmt() / 100).toString(),
                          widget.selectedDate,
                          timeFormater,
                          widget.appointmentDate[widget.selectedIndex]);
                      bookAppointment((getAmt() / 100).toString(),
                          formattedDate, timeFormater);
                      const successsnackBar = SnackBar(
                        content: Text(
                          'Payment Successful',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(successsnackBar);
                    },
                    onFailure: (fa) {
                      const failedsnackBar = SnackBar(
                        content: Text(
                          'Payment Failed',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(failedsnackBar);
                    },
                    onCancel: () {
                      const cancelsnackBar = SnackBar(
                        content: Text(
                          'Payment Cancelled',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(cancelsnackBar);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future transaction(dynamic date, String amount, String selectedDate,
      String time, String appointment_time) async {
    await FirebaseFirestore.instance.collection("users").doc(_user!.uid).update(
        widget._userModel.transactionList(
            date, amount, selectedDate, true, time, appointment_time));
  }
}
