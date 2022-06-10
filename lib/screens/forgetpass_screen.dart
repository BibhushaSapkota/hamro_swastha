import 'package:flutter/material.dart';
import 'package:mero_doctor/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EnterEmailPage extends StatelessWidget {
  const EnterEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_SECONDARY,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        child: Column(children: [
          const Text(
            "Reset Password",
            style: TextStyle(color: COLOR_SECONDARY, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "E-mail",
            style: TextStyle(color: COLOR_GREY, fontSize: 20),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Email should not be empty";
              }
              return null;
            },
            decoration: const InputDecoration(
              fillColor: Colors.black12,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            style: const TextStyle(
                fontSize: 16, height: 0.8, color: Colors.black54),
            keyboardType: TextInputType.text,
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/sendotp");
              },
              color: COLOR_SECONDARY,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              minWidth: screen.width / 2,
              height: 50,
              child: const Text(
                "SEND OTP",
                style: TextStyle(color: COLOR_WHITE, fontSize: 18),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
