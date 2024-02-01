// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/screens/login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ForgotPasswordScreen> {

  TextEditingController forgotPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ForgotPassword",
          style: TextStyle(
              fontFamily: 'DancingScript',
              fontSize: 40,
              fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              alignment: Alignment.center,
              height: 220,
              child: Lottie.asset("assets/Animations/Animation3.json"),
            ),
            const SizedBox(height: 15),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: forgotPasswordController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                var forgotEmail = forgotPasswordController.text.trim();
                try{
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: forgotEmail
                  ).then((value) => {
                    print("Email Sent!"),
                    Get.off(() => const LoginScreen()),
                  });
                } on FirebaseAuthException catch(e) {
                  print("Error $e");
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.deepPurpleAccent),
                foregroundColor: MaterialStatePropertyAll(Colors.black87),
                elevation: MaterialStatePropertyAll(10),
                shadowColor: MaterialStatePropertyAll(Colors.deepPurpleAccent),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              child: const Text("Forgot Password"),
            ),
          ],
        ),
      ),
    );
  }
}
