import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_management/StudentList.dart';
import 'package:student_management/addLeaveApplication.dart';
import 'package:student_management/constants.dart';
import 'package:student_management/leaveApplication.dart';
import 'package:student_management/posts.dart';
import 'package:student_management/webpage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
// import 'package:student_management/lib/home_screen/widgets/student_data.dart';
import 'model.dart';
import 'student.dart';
import 'teacher.dart';
import 'home_screen/widgets/student_data.dart';
import 'webpage.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  // var _role;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var rooll;
  var emaill;
  var id;
  var name;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrool.toString();
        id = loggedInUser.uid.toString();
        name = loggedInUser.name.toString();
      });
    });
  }

  routing() {
    if (rooll == 'Student') {
      return Student(
        id: id,
      );
    } else {
      return Teacher(
        id: id,
      );
    }
  }

  categoryy(String roll) {
    if (rooll == 'Student') {
      roll = 'Miscellaneous';
    } else {
      roll = 'Student\nList';
    }
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    // categoryy(_role);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stugether Home'),
        backgroundColor: kPrimaryColor,
        titleTextStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hey There!",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          name,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                        ),
                        Text(
                          rooll + '( ' + emaill + ' ) ',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          )),
                        )
                      ],
                    ),
                    StudentPicture(
                        picAddress: 'assets/images/logo.png',
                        onPress: () {
                          //                 // go to profile detail screen here
                          //                 // Navigator.pushNamed(
                          //                 // context, MyProfileScreen.routeName);
                        }),
                  ],
                )
              ],
            ),
          )
          //we will divide the screen into two parts
          //fixed height for first half
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   padding: EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               StudentName(
          //                 studentName: '',
          //               ),
          //               kHalfSizedBox,
          //               StudentClass(studentClass: 'Welcome to Stugether'),
          //               kHalfSizedBox,
          //               StudentYear(studentYear: '2019-2023'),
          //             ],
          //           ),
          //           // kHalfSizedBox,
          //           StudentPicture(
          //               picAddress: 'assets/images/logo.png',
          //               onPress: () {
          //                 // go to profile detail screen here
          //                 // Navigator.pushNamed(
          //                 // context, MyProfileScreen.routeName);
          //               }),
          //         ],
          //       ),
          //       sizedBox,
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           StudentDataCard(
          //             onPress: () {
          //               //go to attendance screen
          //             },
          //             title: 'Attendance',
          //             value: '90.02%',
          //           ),
          //           StudentDataCard(
          //             onPress: () {
          //               //go to fee due screen
          //               // Navigator.pushNamed(context, FeeScreen.routeName);
          //             },
          //             title: 'Fees Due',
          //             value: '600\$',
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),

          //other will use all the remaining height of screen
          ,
          Expanded(
            child: Container(
              // width: 100.0,
              decoration: BoxDecoration(
                color: kOtherColor,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            // Navigator.push(context, routing());
                            if (rooll == 'Student') {
                              // return Student(
                              //   id: id,
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Student(id: id)));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => posts()));
                            }
                          },
                          icon: 'assets/icons/posts.svg',
                          title: 'Posts',
                        ),
                        HomeCard(
                          onPress: () {
                            if (rooll == 'Student') {
                              // return Student(
                              //   id: id,
                              // );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addLeave()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          leaveApplication()));
                            }
                          },
                          icon: 'assets/icons/resume.svg',
                          title: 'Leave\nApplication',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      link: 'https://canvas.instructure.com/',
                                      webTitle: 'Canvas Instructure',
                                    )));
                          },
                          icon: 'assets/icons/canvas.svg',
                          title: 'Canvas\nInstructure',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      link: 'https://classroom.google.com/u/0/',
                                      webTitle: 'Google Classroom',
                                    )));
                          },
                          icon: 'assets/icons/classroom.svg',
                          title: 'Google\nClassroom',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      link:
                                          'https://g01.tcsion.com/SelfServices/',
                                      webTitle: 'TCS Self Service',
                                    )));
                          },
                          icon: 'assets/icons/tcsself.svg',
                          title: 'TCS Self',
                        ),
                        HomeCard(
                          //https://www.tcsion.com/LX/login#lx
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      link:
                                          'https://www.tcsion.com/LX/login#lx',
                                      webTitle: 'TCS LX',
                                    )));
                          },
                          icon: 'assets/icons/tcslx.svg',
                          title: 'TCSion LX',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            if (rooll == 'Student') {
                              // return Student(
                              //   id: id,
                              // );
                              Widget ok = TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"));

                              AlertDialog alert = AlertDialog(
                                title: Text("Access Restricted"),
                                actions: [ok],
                              );

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => studentList()));
                            }
                          },
                          icon: 'assets/icons/result.svg',
                          title: 'Student List',
                        ),
                        HomeCard(
                          //https://www.tcsion.com/LX/login#lx
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebviewPage(
                                      link: 'https://www.jklu.edu.in',
                                      webTitle: 'JK Lakshmipat University',
                                    )));
                          },
                          icon: 'assets/icons/university.svg',
                          title: 'Know your\nUniversity',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Widget ok = TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"));

                            AlertDialog alert = AlertDialog(
                              title: Text(
                                "No quiz is currently live. Come back later!",
                                style: TextStyle(fontSize: 15),
                              ),
                              actions: [ok],
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                });
                          },
                          icon: 'assets/icons/quiz.svg',
                          title: 'Take Quiz',
                        ),
                        HomeCard(
                          onPress: () {
                            Widget ok = TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"));

                            AlertDialog alert = AlertDialog(
                              title: Text(
                                "Please check Classroom for Latest Assignments",
                                style: TextStyle(fontSize: 15),
                              ),
                              actions: [ok],
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                });
                          },
                          icon: 'assets/icons/assignment.svg',
                          title: 'Assignments',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {
                            Widget ok = TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"));

                            AlertDialog alert = AlertDialog(
                              title: Text(
                                "Kindly connect with Support at stugetherteam@gmail.com",
                                style: TextStyle(fontSize: 15),
                              ),
                              actions: [ok],
                            );

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                });
                          },
                          icon: 'assets/icons/lock.svg',
                          title: 'Change\nPassword',
                        ),
                        HomeCard(
                          onPress: () {
                            logout(context);
                          },
                          icon: 'assets/icons/logout.svg',
                          title: 'Logout',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return routing();
  }
}

Future<void> logout(BuildContext context) async {
  CircularProgressIndicator();
  await FirebaseAuth.instance.signOut();

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.onPress,
      required this.icon,
      required this.title})
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 25.0),
        width: MediaQuery.of(context).size.width * 0.42,
        height: 180.0,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10.0 / 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: 70.0,
              width: 70.0,
              color: Colors.white,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.white, fontSize: 17)),
              // TextStyle(
              // color: Colors.white, fontSize: 16, fontFamily: 'RobotoMono'),
            ),
          ],
        ),
      ),
    );
  }
}
