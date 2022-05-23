import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetUserEmail {
  String? isPatient(String email) {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    var collection = FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      if (value.data()!['email'] == email &&
          value.data()!['isPatient'] == true) {
        return 'true';
      }
    }).catchError((e) {
      print(e);
    });
    return 'false';
  }

  Future<bool> isDoctor(String email) async {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    var collection = FirebaseFirestore.instance.collection("doctors");
    var docData = await collection.doc(user!.uid).get();
    if (docData.data()!['email'] == email &&
        docData.data()!['isDoctor'] == true) {
      return true;
    }
    return false;
  }
}
