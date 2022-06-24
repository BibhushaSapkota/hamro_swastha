import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:mero_doctor/models/user.dart';
import 'package:mero_doctor/screens/payment_screen.dart';

class KhaltiPaymentPage extends StatefulWidget {
  KhaltiPaymentPage({Key? key, this.getPay}) : super(key: key);
  final String? getPay;
  final UserModel _userModel = UserModel();
  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController.text = "${widget.getPay}";
  }

  int getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
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
                      builder: (context) => const PaymentScreen()),
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
                      productIdentity: '',
                      productName: '',
                    ),
                    preferences: [
                      PaymentPreference.khalti,
                      PaymentPreference.connectIPS,
                    ],
                    onSuccess: (su) {
                      dynamic date = DateTime.now().toString();
                      transaction(date, getAmt().toString());
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

  Future transaction(dynamic date, String amount) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc('2qTTJHYhnIahXmzC3HKV8WAet7Y2')
        .update(widget._userModel.favoriteList(date, amount));
  }
}
