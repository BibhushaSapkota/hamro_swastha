import 'package:flutter/material.dart';
import 'package:mero_doctor/utils/constants.dart';

class EnterOtpPage extends StatelessWidget {
  FocusNode focusnode1 = FocusNode();
  FocusNode focusnode2 = FocusNode();
  FocusNode focusnode3 = FocusNode();
  FocusNode focusnode4 = FocusNode();

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
            "We have sent an OTP to \n your email",
            style: TextStyle(color: COLOR_SECONDARY, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Please enter the OTP sent to your email \n to continue to reset your password",
            style: TextStyle(color: COLOR_BLACK, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildotpvalue(focusnode1, onchanged: (val) {
                if (val.isNotEmpty) focusnode2.requestFocus();
              }),
              SizedBox(
                width: 100,
              ),
              _buildotpvalue(focusnode2, onchanged: (val) {
                if (val.isNotEmpty) focusnode3.requestFocus();
              }),
              SizedBox(
                width: 100,
              ),
              _buildotpvalue(focusnode3, onchanged: (val) {
                if (val.isNotEmpty) focusnode4.requestFocus();
              }),
              SizedBox(
                width: 100,
              ),
              _buildotpvalue(focusnode4, onchanged: (val) {
                if (val.isNotEmpty) focusnode1.requestFocus();
              }),
              SizedBox(
                width: 100,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
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
                "Next",
                style: TextStyle(color: COLOR_WHITE, fontSize: 18),
              ),
            ),
          ),
        ]),
      ),
    );
    ;
  }

  Expanded _buildotpvalue(FocusNode focusNode,
      {ValueChanged<String>? onchanged}) {
    return Expanded(
        child: TextFormField(
      focusNode: focusNode,
      decoration: const InputDecoration(
        fillColor: Color.fromARGB(31, 65, 60, 60),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      style: TextStyle(color: COLOR_GREY, fontSize: 20),
      textAlign: TextAlign.center,
      obscureText: true,
      obscuringCharacter: "*",
      onChanged: onchanged,
    ));
  }
}
