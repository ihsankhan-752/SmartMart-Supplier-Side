import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  String _username = '';
  String _userImage = '';

  String get username => _username;
  String get userImage => _userImage;

  getUser() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (snap.exists) {
      _username = snap['userName'];
      _userImage = snap['image'];
      notifyListeners();
    }
  }
}
