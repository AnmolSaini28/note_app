
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:note_app/screens/login_screen.dart';

signUpUser(String userName,
    String email,
    String password
    ) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try{
    await FirebaseFirestore.instance.collection("Users").doc(userid!.uid).set(
        {
          'userName' : userName,
          'userEmail' : email,
          'createdAt' : DateTime.now(),
          'userId' : userid.uid,
        }
    ).then((value) => {
      FirebaseAuth.instance.signOut(),
      Get.to(() => const LoginScreen()),
    });
  } on FirebaseAuthException catch(e){
    print("Error $e");
  }
}