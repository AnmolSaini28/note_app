// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/screens/home_screen.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {

  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Note",
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
              controller: noteController..text = "${Get.arguments['Note'].toString()}",
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Edit Note",
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
                enabledBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
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
                onPressed: () async {
                  await FirebaseFirestore.instance.collection("Notes").doc(Get.arguments['docId'].toString()).update({
                    'Note' : noteController.text.trim(),
                  },
                  ).then((value) => {
                    Get.offAll(() => const HomeScreen()),
                    print("Data Updated"),
                  });
                },
                child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
