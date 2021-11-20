import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home_screen.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  var _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.pink,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (item) {
                            return item.contains("@")
                                ? null
                                : "Enter valid Email";
                          },
                          onChanged: (item) {
                            setState(() {
                              _email = item;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Email",
                              labelText: "Email",
                            labelStyle: new TextStyle(color: Colors.green),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.pink, width: 2.0,
                                ),
                              ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          validator: (item) {
                            return item.length > 5
                                ? null
                                : "Password must be 6 characters long";
                          },
                          onChanged: (item) {
                            setState(() {
                              _password = item;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                            labelStyle: new TextStyle(color: Colors.green),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pink, width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.pinkAccent,
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              "Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            ),
                            textColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) =>  RegistrationScreen()));
                          },
                          child: Text("Register here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.orange),), ),alignment: Alignment.centerRight,)
                      ],
                    )),
              ),
          ),
    );
  }

  void login() {
    if (_formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        // sign up
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: "Login Success");

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
            (Route<dynamic> route) => false);
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    }
  }
}
