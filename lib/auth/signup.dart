//import './../home_bottom_navigation_screen.dart';
// import 'package:ecommerce_int2/app_properties.dart';

import 'package:flutter/material.dart';
//import './../home_donor.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'forgot_password_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController cmfPassword = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You, Lets Sign Up',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ));

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 8,
      bottom: 40,
      child: InkWell(
        onTap: () {
          setState(() {
            loading = true;
          });
          _auth
              .createUserWithEmailAndPassword(
                  email: email.text, password: password.text)
              .then((value) {
            _db.collection("users").doc(value.user.uid).set({
              "email": value.user.email,
              "cycle": "",
            }).then((value) {
              setState(() {
                loading = false;
              });
              _auth.signOut();
              Navigator.pop(context);
            });
          }).catchError((error) {
            setState(() {
              loading = false;
              Fluttertoast.showToast(msg: 'Server Error');
            });
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          height: 80,
          child: Center(
              child: new Text("Sign-Up",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ], borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    //  Widget registerButton1 = Positioned(
    //   left: MediaQuery.of(context).size.width /2,
    //   bottom: 40,
    //   child: InkWell(
    //     onTap: () {
    //       // Navigator.of(context)
    //       //     .push(MaterialPageRoute(builder: (_) => HomeBottomNavigationScreen()));
    //     },
    //     child: Container(
    //       width: MediaQuery.of(context).size.width / 3.1,
    //       height: 80,
    //       child: Center(
    //           child: new Text("NGO",
    //               // textAlign: TextAlign.center,
    //
    //               style: const TextStyle(
    //                   // height: 1.5,
    //                   color: const Color(0xfffefefe),
    //                   fontWeight: FontWeight.w600,
    //                   fontStyle: FontStyle.normal,
    //                   fontSize: 20.0))),
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [
    //                 Color.fromRGBO(236, 60, 3, 1),
    //                 Color.fromRGBO(234, 60, 3, 1),
    //                 Color.fromRGBO(216, 78, 16, 1),
    //               ],
    //               begin: FractionalOffset.topCenter,
    //               end: FractionalOffset.bottomCenter),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Color.fromRGBO(0, 0, 0, 0.16),
    //               offset: Offset(0, 5),
    //               blurRadius: 10.0,
    //             )
    //           ],
    //           borderRadius: BorderRadius.circular(9.0)),
    //     ),
    //   ),
    // );

    Widget registerForm = Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Username"),
                    controller: email,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Enter Password"),
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Re-enter Password"),
                    controller: cmfPassword,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          registerButton,
          // registerButton1,
        ],
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        // Text(
        //   'You can sign in with',
        //   style: TextStyle(
        //       fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.find_replace),
        //       onPressed: () {},
        //       color: Colors.white,
        //     ),
        //     IconButton(
        //         icon: Icon(Icons.find_replace),
        //         onPressed: () {},
        //         color: Colors.white),
        //   ],
        // )
      ],
    );

    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                // Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(image: AssetImage('assets/background.jpg'),
                //           fit: BoxFit.cover)
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(
                    // color: transparentYellow,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Spacer(flex: 3),
                      title,
                      Spacer(),
                      subTitle,
                      Spacer(flex: 2),
                      registerForm,
                      Spacer(flex: 2),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: socialRegister)
                    ],
                  ),
                ),

                Positioned(
                  top: 35,
                  left: 5,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
    );
  }
}
