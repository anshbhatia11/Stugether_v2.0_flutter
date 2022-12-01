import 'package:student_management/home.dart';
import 'posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'leaveApplication.dart';

class addLeave extends StatelessWidget {
  String finalText = '';
  TextEditingController title = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('leave');
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .where('wrool', isEqualTo: 'Student')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              finalText = title.text;
              ref.add({
                'title': title.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              });
            },
            child: Text("Request Leave",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Important:\n1. Please Mention your name and email before stating your request.\n2. The name of Course and Faculty should be clearly mentioned\n3. The faculty shall directly mail you once the request is approved.\n4. Avoid sharing multiple requests",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                  fontSize: 14,
                )),
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 10),
                  child: TextField(
                    controller: title,
                    expands: true,
                    maxLines: null,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                      fontSize: 16,
                    )),
                    decoration: InputDecoration(
                      hintText:
                          'Please comply with Instructions\nbefore applying for leave',
                      hintStyle: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                        fontSize: 16,
                      )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
