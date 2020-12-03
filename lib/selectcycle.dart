import 'package:abh/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectCycle extends StatefulWidget {
  final User user;
  SelectCycle({this.user});
  @override
  _SelectCycleState createState() => _SelectCycleState();
}

class _SelectCycleState extends State<SelectCycle> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> cycles;

  bool loading = true;

  Future<QuerySnapshot> getcycle() {
    return _db.collection("cycles").where("available", isEqualTo: true).get();
  }

  @override
  void initState() {
    super.initState();
    getcycle().then((value) {
      cycles = value.docs;
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Available Cycles'),
          centerTitle: true,
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      height: 80,
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.car_repair),
                          ),
                          title: Text(
                            cycles[index]["bikecode"],
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: FlatButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Confirm Selection'),
                                        titlePadding: EdgeInsets.all(20),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Confirm to Select this cycle'),
                                            Text(
                                                'Cycle Code is ${cycles[index]["bikecode"]}')
                                          ],
                                        ),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                loading = true;
                                              });
                                              _db
                                                  .collection("users")
                                                  .doc(widget.user.uid)
                                                  .update({
                                                "cycle": cycles[index].id
                                              }).then((value) {
                                                _db
                                                    .collection("cycles")
                                                    .doc(cycles[index].id)
                                                    .update({
                                                  "available": false,
                                                  "currentuser":
                                                      widget.user.uid,
                                                });
                                                setState(() {
                                                  loading = false;
                                                });
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MyApp2(
                                                    user: widget.user,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                'Select',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 16),
                              )),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: cycles.length,
              ),
      ),
    );
  }
}
