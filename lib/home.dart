import 'package:abh/auth/login_page.dart';
import 'package:abh/selectcycle.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatefulWidget {
  final User user;
  MyApp2({
    this.user,
  });
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  bool loading = false;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  tmpFunction() {
    print('Function on Click Event Called.');
    // Put your code here, which you want to execute on onPress event.
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    print(widget.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: CircleAvatar(),
                ),
                Divider(
                  thickness: 3,
                ),
                ListTile(
                  title: Text("Account"),
                  leading: Icon(Icons.supervised_user_circle),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Payment"),
                  leading: Icon(Icons.payment),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.exit_to_app),
                  onTap: () {
                    _auth.signOut().then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomeBackPage()));
                    });
                  },
                ),
              ],
            ),
          ),
          backgroundColor: Colors.lightBlue,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Social Cycle'),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: loading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image(
                          image: AssetImage('images/bike.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 1,
                    ),
                    MaterialButton(
                      child: Text(
                        'Select Cycle',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      color: Colors.pink,
                      highlightColor: Colors.orange,
                      splashColor: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        _db
                            .collection("users")
                            .doc(widget.user.uid)
                            .get()
                            .then((value) {
                          Map<String, dynamic> data = value.data();
                          if (data["cycle"] == "") {
                            setState(() {
                              loading = false;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectCycle(
                                            user: widget.user,
                                          )));
                            });
                          } else {
                            setState(() {
                              loading = false;
                              Fluttertoast.showToast(
                                  msg:
                                      "already have cycle ID ${data["cycle"]}");
                            });
                          }
                        });
                      },
                      minWidth: 175,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: new Text(
                        'De-Select Cycle',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      color: Colors.pink,
                      highlightColor: Colors.orange,
                      splashColor: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        _db
                            .collection("users")
                            .doc(widget.user.uid)
                            .get()
                            .then((value) {
                          Map<String, dynamic> data = value.data();
                          if (data["cycle"] != "") {
                            _db
                                .collection('cycles')
                                .doc(data["cycle"])
                                .update({"currentuser": "", "available": true});
                            _db
                                .collection("users")
                                .doc(widget.user.uid)
                                .update({"cycle": ""}).then((value) {
                              setState(() {
                                loading = false;
                                Fluttertoast.showToast(
                                    msg: "Cycle returned successfully");
                              });
                            });
                          } else {
                            setState(() {
                              loading = false;
                              Fluttertoast.showToast(msg: "No Cycle Taken");
                            });
                          }
                        });
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
