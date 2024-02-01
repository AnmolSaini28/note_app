import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_app/screens/createnote_screen.dart';
import 'package:note_app/screens/editnote_screen.dart';
import 'package:note_app/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
            "Home Screen",
          style: TextStyle(
              fontFamily: 'DancingScript',
              fontSize: 40,
              fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: (){
              FirebaseAuth.instance.signOut();
              Get.to(() => const LoginScreen());
            },
            child: const Icon(
                Icons.logout_sharp,
              size: 40.0,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection
            ("Notes").where("userId", isEqualTo: userId?.uid).
          snapshots(),

          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"));
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CupertinoActivityIndicator());
            }
            if(snapshot.data!.docs.isEmpty){
              return const Center(child: Text("No Data Found!"));
            }
            if(snapshot.data != null){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                  var note = snapshot.data!.docs[index]['Note'];
                  var docId = snapshot.data!.docs[index].id;
                  return Card(
                    color: Colors.white54,
                    child: ListTile(
                      title: Text(note),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const EditNoteScreen(),
                                arguments: {
                                'Note' : note,
                                  'docId' : docId,
                                }
                              );
                            },
                              child: const Icon(Icons.edit)
                          ),
                          const SizedBox(width: 10.0,),
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance.collection("Notes").doc(docId).delete();
                            },
                              child: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                  }
              );
            }

            return Container();

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.black,
          onPressed: (){
          Get.to(() => const CreateNoteScreen());
          },
          child: const Icon(Icons.add),
          ),
    );
  }
}
