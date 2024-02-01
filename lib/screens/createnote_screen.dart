// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {

  final TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a Note",
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
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Add Note",
                  hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                  ),
                  enabledBorder: OutlineInputBorder(),
                ),
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
                  var note = noteController.text.trim();

                  if(note != " "){
                    try{
                      await FirebaseFirestore.instance.collection("Notes").doc().set({
                        "createdAt" : DateTime.now(),
                        "Note" : note,
                        "userId" : userId?.uid,
                      });
                    } catch(e){
                      print("Error $e");
                    }
                  }
                },
                child: const Text("Add Note"),
            )
          ],
        ),
      ),
    );
  }
}
