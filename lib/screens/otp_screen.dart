import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mero_doctor/screens/forgetpass_screen.dart';
import 'package:mero_doctor/utils/constants.dart';

class EnterOtpPage extends StatefulWidget {
  EnterOtpPage({this.email}) : super();
  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState(email);
  String? email;
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  _EnterOtpPageState(this.email);
  String? email;

  FocusNode focusnode1 = FocusNode();

  FocusNode focusnode2 = FocusNode();

  FocusNode focusnode3 = FocusNode();

  FocusNode focusnode4 = FocusNode();

  bool? isValid;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_SECONDARY,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const EnterEmailPage()),
                (route) => false);
          },
        ),
        title: Text(
          "OTP Verification",
          style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 18)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Text(
                "We have sent an OTP to your email",
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 21,
                        color: COLOR_SECONDARY,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 22),
              child: Center(
                child: Text(
                  "Please enter the OTP sent to ${email!} to reset your password",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                _buildotpvalue(focusnode1, onchanged: (val) {
                  if (val.length == 1) focusnode2.requestFocus();
                }),
                const SizedBox(
                  width: 20,
                ),
                _buildotpvalue(focusnode2, onchanged: (val) {
                  if (val.length == 1) focusnode3.requestFocus();
                }),
                const SizedBox(
                  width: 20,
                ),
                _buildotpvalue(focusnode3, onchanged: (val) {
                  if (val.length == 1) focusnode4.requestFocus();
                }),
                const SizedBox(
                  width: 20,
                ),
                _buildotpvalue(focusnode4, onchanged: (val) {
                  if (val.length == 1) FocusScope.of(context).nextFocus();
                }),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            if (isValid != null && !isValid!) ...[
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please! Enter your OTP number",
                style: GoogleFonts.poppins(
                    textStyle:
                        const TextStyle(color: Colors.red, fontSize: 16)),
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && isValid!) {
                    Navigator.pushReplacementNamed(context, "/");
                  }
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
      ),
    );
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
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      style: const TextStyle(color: COLOR_GREY, fontSize: 25),
      textAlign: TextAlign.center,
      obscureText: true,
      obscuringCharacter: "*",
      onChanged: onchanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          setState(() {
            isValid = false;
          });
        } else {
          setState(() {
            isValid = true;
          });
        }
        return null;
      },
    ));
  }
}
