import 'package:flutter/material.dart';

void main() {
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  bool _hasBeenPressed = false;
  tmpFunction() {
    print('Function on Click Event Called.');
    // Put your code here, which you want to execute on onPress event.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.lightBlue,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Social Cycle'),
            backgroundColor: Colors.blueGrey[900],
          ),

          body: Column(
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
                child: new Text(
                  'Select Cycle',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                color: Colors.pink,
                highlightColor: Colors.orange,
                splashColor: Colors.yellow,
                onPressed: tmpFunction,
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
                onPressed: tmpFunction,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
